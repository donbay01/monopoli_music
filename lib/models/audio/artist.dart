import 'package:json_annotation/json_annotation.dart';

import 'visuals.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artists {
  final int totalCount;
  final List<Artist>? items;

  Artists({required this.totalCount, this.items});

  factory Artists.fromJson(Map<String, dynamic> json) =>
      _$ArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistsToJson(this);
}

@JsonSerializable()
class Artist {
  final String? type;
  final String? id;
  final String? name;
  final String? shareUrl;
  final bool? verified;
  final Visuals? visuals;

  Artist({
    this.type,
    this.id,
    this.name,
    this.shareUrl,
    this.verified,
    this.visuals,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
