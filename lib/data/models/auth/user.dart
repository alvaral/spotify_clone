// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:spotify_clone_flutter/domain/entities/auth/user_entity.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageUrl;

  UserModel({
    required this.email,
    required this.fullName,
    required this.imageUrl,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
    imageUrl = data['imageUrl'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      imageURL: imageUrl,
      email: email,
      fullName: fullName,
    );
  }
}
