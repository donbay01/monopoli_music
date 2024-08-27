import 'package:json_annotation/json_annotation.dart';
import 'album.dart';
import 'artist.dart';
import 'cover.dart';
import 'episode.dart';
import 'genre.dart';
import 'track.dart';
part 'models.g.dart';

@JsonSerializable()
class ResponseData {
  final bool status;
  final String errorId;
  final Albums? albums;
  final Artists? artists;
  final Episodes? episodes;
  final Genres? genres;
  // final Playlists playlists;
  // final Podcasts podcasts;
  final Tracks? tracks;
  // final Users users;

  ResponseData({
    required this.status,
    required this.errorId,
    this.albums,
    this.artists,
    this.episodes,
    this.genres,
    // required this.playlists,
    // required this.podcasts,
    this.tracks,
    // required this.users,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}
