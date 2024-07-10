class UserEntity {
  final String? fullName;
  final String? email;
  String? imageURL;

  UserEntity({
    required this.email,
    required this.fullName,
    this.imageURL,
  });
}
