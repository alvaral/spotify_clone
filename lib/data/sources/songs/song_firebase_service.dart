// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_clone_flutter/data/models/song/song_model.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';

sealed class SongFirebaseService {
  Future<Either> getNewsSongs();

  Future<Either> getPlayList();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
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
}
