import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify_clone_flutter/domain/usecases/song/get_play_list_use_case.dart';
import 'package:spotify_clone_flutter/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());
  bool _isClosed = false;

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold(
      (l) {
        log('play_list_cubit $l');
        if (!_isClosed) {
          emit(PlayListLoadFailure());
        }
      },
      (data) {
        if (!_isClosed) {
          emit(PlayListLoaded(songs: data));
        }
      },
    );
  }
}
