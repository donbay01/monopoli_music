import 'package:json_annotation/json_annotation.dart';

import 'author.dart';
import 'cover.dart';
part 'audio_books.g.dart';

@JsonSerializable()
class Audiobooks {
  final int totalCount;
  final List<Audiobook> items;

  Audiobooks({required this.totalCount, required this.items});

  factory Audiobooks.fromJson(Map<String, dynamic> json) =>
      _$AudiobooksFromJson(json);

  Map<String, dynamic> toJson() => _$AudiobooksToJson(this);
}

@JsonSerializable()
class Audiobook {
  final String type;
  final String id;
  final String name;
  final String shareUrl;
  final String date;
  final List<Author> authors;
  final List<Cover> cover;

  Audiobook({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
    required this.date,
    required this.authors,
    required this.cover,
  });

  factory Audiobook.fromJson(Map<String, dynamic> json) =>
      _$AudiobookFromJson(json);

  Map<String, dynamic> toJson() => _$AudiobookToJson(this);
}
