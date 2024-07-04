import 'package:dartz/dartz.dart';
import 'package:spotify_clone_flutter/core/usecase.dart/usecase.dart';
import 'package:spotify_clone_flutter/data/models/auth/sign_in_user_req.dart';
import 'package:spotify_clone_flutter/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class SignInUseCase implements UseCase<Either, SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq? params}) {
    return sl<AuthRepository>().signIn(params!);
  }
}
