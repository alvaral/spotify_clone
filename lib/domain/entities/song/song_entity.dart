import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;

  SongEntity(
    this.title,
    this.artist,
    this.duration,
    this.releaseDate,
  );
}
