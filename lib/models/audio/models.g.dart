// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      status: (json['status'] ?? false) as bool,
      errorId: json['errorId'] as String,
      albums: json['albums'] == null
          ? null
          : Albums.fromJson(json['albums'] as Map<String, dynamic>),
      artists: json['artists'] == null
          ? null
          : Artists.fromJson(json['artists'] as Map<String, dynamic>),
      episodes: json['episodes'] == null
          ? null
          : Episodes.fromJson(json['episodes'] as Map<String, dynamic>),
      genres: json['genres'] == null
          ? null
          : Genres.fromJson(json['genres'] as Map<String, dynamic>),
      tracks: json['tracks'] == null
          ? null
          : Tracks.fromJson(json['tracks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorId': instance.errorId,
      'albums': instance.albums,
      'artists': instance.artists,
      'episodes': instance.episodes,
      'genres': instance.genres,
      'tracks': instance.tracks,
    };
