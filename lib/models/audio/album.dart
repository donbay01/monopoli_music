import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';
import 'content.dart';
import 'cover.dart';

part 'album.g.dart';

@JsonSerializable()
class Albums {
  final int totalCount;
  final List<Album> items;

  Albums({required this.totalCount, required this.items});

  factory Albums.fromJson(Map<String, dynamic> json) => _$AlbumsFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}

@JsonSerializable()
class Album {
  final String? type;
  final String? id;
  final String? name;
  final String? shareUrl;
  final String? date;
  final List<Artist>? artists;
  final List<Cover>? cover;
  final Content? content;
  final List<Cover>? images;

  Album({
    this.type,
    this.id,
    this.name,
    this.shareUrl,
    this.date,
    this.artists,
    this.cover,
    this.content,
    this.images,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
