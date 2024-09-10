import 'package:dartz/dartz.dart';
import 'package:spotify_clone_flutter/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_flutter/data/models/auth/sign_in_user_req.dart';
import 'package:spotify_clone_flutter/data/sources/auth/auth_firebase_datasource.dart';
import 'package:spotify_clone_flutter/domain/repository/auth/auth_repository.dart';

import 'package:spotify_clone_flutter/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    return await sl<AuthFirebaseDatasource>().signIn(signInUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseDatasource>().signUp(createUserReq);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseDatasource>().getUser();
  }
}
