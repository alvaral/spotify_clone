import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify_clone_flutter/domain/usecases/song/get_news_songs_use_case.dart';
import 'package:spotify_clone_flutter/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());
  bool _isClosed = false;

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    if (_isClosed) return;
    returnedSongs.fold(
      (l) {
        log('news_songs_cubit $l');
        emit(NewsSongsLoadFailure());
      },
      (data) {
        if (!_isClosed) {
          emit(NewsSongsLoaded(songs: data));
        }
      },
    );
  }
}
