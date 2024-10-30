import 'package:json_annotation/json_annotation.dart';

import 'album.dart';
import 'artist.dart';
part 'track.g.dart';

@JsonSerializable()
class Tracks {
  final int totalCount;
  final List<Track> items;

  Tracks({
    required this.totalCount,
    required this.items,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) => _$TracksFromJson(json);

  Map<String, dynamic> toJson() => _$TracksToJson(this);
}

@JsonSerializable()
class Track {
  final String type;
  final String id;
  final String name;
  final String label;
  final String shareUrl;
  final bool explicit;
  final int durationMs;
  final String durationText;
  final List<Artist> artists;
  final Album album;

  Track({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
    required this.explicit,
    required this.durationMs,
    required this.durationText,
    required this.artists,
    required this.album,
    required this.label,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
