// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_flutter/data/models/song/song_model.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_flutter/domain/usecases/song/is_favorite_song_use_case.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

sealed class SongFirebaseDatasource {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseDatasourceImpl extends SongFirebaseDatasource {
  @override
  Future<Either> getNewsSongs() async {
    List<SongEntity> songs = [];
    try {
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('release_date', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(
          songModel.toEntity(),
        );
      }
      return Right(songs);
    } catch (e) {
      return Left(
          'An error occurred, Please try again. Error: ' + e.toString());
    }
  }

  @override
  Future<Either> getPlayList() async {
    List<SongEntity> songs = [];
    try {
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('release_date', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        log('song_firebase_service: isFavorite $isFavorite');
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(
          songModel.toEntity(),
        );
      }
      return Right(songs);
    } catch (e) {
      return Left(
          'An error occurred, Please try again. Error: ' + e.toString());
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;

      bool isFavorite = false;

      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
      } else {
        isFavorite = true;
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('favorites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now(),
        });
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;

      bool isFavorite = false;

      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('favorites')
          .where(
            'songId',
            isEqualTo: songId,
          )
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        isFavorite = true;
      }
      return isFavorite;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      List<SongEntity> favoriteSongs = [];

      var user = firebaseAuth.currentUser;

      String uId = user!.uid;

      QuerySnapshot favoriteSongsQuerySnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('favorites')
          .get();

      for (var element in favoriteSongsQuerySnapshot.docs) {
        String songId = element['songId'];

        var song =
            await firebaseFirestore.collection('songs').doc(songId).get();

        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSongs.add(songModel.toEntity());
      }
      return Right(favoriteSongs);
    } catch (e) {
      log('song_firebase_service: $e');
      return const Left('An error occurred.');
    }
  }
}
