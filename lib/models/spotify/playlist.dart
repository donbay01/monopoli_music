import 'package:monopoli/models/spotify/category.dart';

class SpotifyPlaylistTrack {
  final String href;
  final int total;

  SpotifyPlaylistTrack.fromJSON(Map<dynamic, dynamic> json)
      : href = json['href'],
        total = json['total'];

  SpotifyPlaylistTrack({
    required this.href,
    required this.total,
  });
}

class SpotifyPlaylist {
  final bool collaborative;
  final String description;
  final String id;
  final String name;

  final String primary_color;
  final bool public;
  final String snapshot_id;

  final List<SpotifyCategoryIcon> images;
  final SpotifyPlaylistTrack track;

  SpotifyPlaylist.fromJSON(Map<dynamic, dynamic> json)
      : collaborative = json['collaborative'],
        description = json['description'],
        id = json['id'],
        name = json['name'],
        primary_color = json['primary_color'],
        public = json['public'],
        images = json['images']
            .map((a) => SpotifyCategoryIcon.fromJSON(a))
            .toList()
            .cast<SpotifyCategoryIcon>(),
        track = SpotifyPlaylistTrack.fromJSON(json['tracks']),
        snapshot_id = json['snapshot_id'];

  SpotifyPlaylist({
    required this.collaborative,
    required this.description,
    required this.id,
    required this.name,
    required this.primary_color,
    required this.public,
    required this.snapshot_id,
    required this.images,
    required this.track,
  });
}

class Album {
  final String id;
  final String name;

  Album.fromJSON(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Album({
    required this.id,
    required this.name,
  });
}

class Track {
  final String? preview_url;
  final bool explicit;
  final String id;
  final String name;
  final int? popularity;
  final Album album;

  Track.fromJSON(Map<dynamic, dynamic> json)
      : popularity = json['popularity'],
        name = json['name'],
        id = json['id'],
        explicit = json['explicit'],
        preview_url = json['preview_url'],
        album = Album.fromJSON(json['album']);

  Track({
    this.preview_url,
    required this.explicit,
    required this.id,
    required this.name,
    this.popularity,
    required this.album,
  });
}

class SpotifyPlaylistTrackResponse {
  final Track track;

  SpotifyPlaylistTrackResponse.fromJSON(Map<String, dynamic> json)
      : track = Track.fromJSON(json['track']);

  SpotifyPlaylistTrackResponse({
    required this.track,
  });
}
