import 'package:dartz/dartz.dart';
import 'package:spotify_clone_flutter/core/usecase.dart/usecase.dart';
import 'package:spotify_clone_flutter/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_flutter/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class SignUpUseCase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signUp(params!);
  }
}
