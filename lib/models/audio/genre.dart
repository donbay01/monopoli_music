import 'package:json_annotation/json_annotation.dart';
import 'cover.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genres {
  final int totalCount;
  final List<Genre> items;

  Genres({required this.totalCount, required this.items});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable()
class Genre {
  final String type;
  final String id;
  final String title;
  final String shareUrl;
  final List<Cover> image;

  Genre({
    required this.type,
    required this.id,
    required this.title,
    required this.shareUrl,
    required this.image,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
