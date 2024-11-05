import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';
import 'cover.dart';
part 'content.g.dart';

@JsonSerializable()
class Content {
  final String? type;
  final String? id;
  final String? name;
  final String? shareUrl;
  final List<Artist>? artists;
  final List<Cover>? cover;

  Content({
    this.type,
    this.id,
    this.name,
    this.shareUrl,
    this.artists,
    this.cover,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
