import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone_flutter/domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;

  SongModel(
    this.title,
    this.artist,
    this.duration,
    this.releaseDate,
  );

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['release_date'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title!,
      artist!,
      duration!,
      releaseDate!,
    );
  }
}
