import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_flutter/domain/usecases/song/get_favorite_songs_use_case.dart';
import 'package:spotify_clone_flutter/presentation/profile/bloc/favorite_songs/favorite_songs_state.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUseCase>().call();

    result.fold((l) {
      // ignore: prefer_interpolation_to_compose_strings
      log('FavoriteSongsCubit: ' + l.toString());
      emit(FavoriteSongsFailure());
    }, (r) {
      favoriteSongs = r;
      emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
    });
  }

  void removeSongFromFavorites(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}
