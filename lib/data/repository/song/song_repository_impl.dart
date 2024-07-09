import 'package:dartz/dartz.dart';
import 'package:spotify_clone_flutter/data/sources/songs/song_firebase_service.dart';
import 'package:spotify_clone_flutter/domain/repository/song/song_repository.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }
}
