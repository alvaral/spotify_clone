import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_flutter/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_flutter/data/models/auth/sign_in_user_req.dart';

sealed class AuthFirebaseService {
  Future<Either> signUp(CreateUserReq createUserReq);

  Future<Either> signIn(SignInUserReq signInUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user!.email,
      });

      return const Right('Signup was Succesfull');
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserReq.email, password: signInUserReq.password);

      return const Right('SignIn was Succesfull');
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? '';

      if (e.code == 'invalid-email') {
        message = 'The email provided is invalid.';
      } else if (e.code == 'invalid-credential') {
        message = 'The credentials provided are wrong.';
      }

      return Left(message);
    }
  }
}
