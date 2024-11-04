import 'package:monopoli/models/spotify/category.dart';

class SpotifyAlbum {
  final int total_tracks;
  final String id;
  final String name;
  final List<SpotifyCategoryIcon> images;

  SpotifyAlbum.fromJSON(Map<String, dynamic> json)
      : total_tracks = json['total_tracks'],
        id = json['id'],
        name = json['name'],
        images = json['images']
            .map((a) => SpotifyCategoryIcon.fromJSON(a))
            .toList()
            .cast<SpotifyCategoryIcon>();

  SpotifyAlbum({
    required this.name,
    required this.total_tracks,
    required this.id,
    required this.images,
  });
}
