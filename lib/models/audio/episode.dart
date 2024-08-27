import 'package:json_annotation/json_annotation.dart';

import 'cover.dart';
part 'episode.g.dart';

@JsonSerializable()
class Episodes {
  final int totalCount;
  final List<Episode> items;

  Episodes({required this.totalCount, required this.items});

  factory Episodes.fromJson(Map<String, dynamic> json) =>
      _$EpisodesFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodesToJson(this);
}

@JsonSerializable()
class Episode {
  final String type;
  final String id;
  final String name;
  final String shareUrl;
  final bool explicit;
  final String date;
  final String description;
  final int durationMs;
  final String durationText;
  final bool paywallContent;
  final List<Cover> cover;
  // final Podcast podcast;

  Episode({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
    required this.explicit,
    required this.date,
    required this.description,
    required this.durationMs,
    required this.durationText,
    required this.paywallContent,
    required this.cover,
    // required this.podcast,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
