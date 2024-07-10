import 'dart:developer';
import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_flutter/domain/usecases/auth/get_user_user_case.dart';
import 'package:spotify_clone_flutter/presentation/profile/bloc/profile_info/profile_info_state.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUserCase>().call();

    user.fold((l) {
      // ignore: prefer_interpolation_to_compose_strings
      log('ProfileInfoCubit: ' + l);
      emit(ProfileInfoFailure());
    }, (userEntity) {
      emit(ProfileInfoLoaded(userEntity: userEntity));
    });
  }
}
