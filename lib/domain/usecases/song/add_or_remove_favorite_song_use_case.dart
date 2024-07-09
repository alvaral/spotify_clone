import 'package:dartz/dartz.dart';
import 'package:spotify_clone_flutter/core/usecase.dart/usecase.dart';
import 'package:spotify_clone_flutter/domain/repository/song/song_repository.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSong(params!);
  }
}
