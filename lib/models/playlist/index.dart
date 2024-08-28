import 'package:monopoli/models/audio/content.dart';

import 'dart:convert';

class Track {
  final String? type;
  final String? id;
  final String? name;
  final String? shareUrl;
  final bool? explicit;
  final int? durationMs;
  final String? durationText;
  final int? discNumber;
  final int? trackNumber;
  final int? playCount;
  final List<Artist>? artists;
  final Album? album;
  final Playlist? playlist;

  Track({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
    required this.explicit,
    required this.durationMs,
    required this.durationText,
    required this.discNumber,
    required this.trackNumber,
    required this.playCount,
    required this.artists,
    required this.album,
    required this.playlist,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      type: json['type'],
      id: json['id'],
      name: json['name'],
      shareUrl: json['shareUrl'],
      explicit: json['explicit'],
      durationMs: json['durationMs'],
      durationText: json['durationText'],
      discNumber: json['discNumber'],
      trackNumber: json['trackNumber'],
      playCount: json['playCount'],
      artists: (json['artists'] as List)
          .map((artistJson) => Artist.fromJson(artistJson))
          .toList(),
      album: Album.fromJson(json['album']),
      playlist: Playlist.fromJson(json['playlist']),
    );
  }
}

class Artist {
  final String type;
  final String id;
  final String name;
  final String shareUrl;

  Artist({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      type: json['type'],
      id: json['id'],
      name: json['name'],
      shareUrl: json['shareUrl'],
    );
  }
}

class Album {
  final String type;
  final String id;
  final String name;
  final String shareUrl;
  final List<Artist> artists;
  final List<Cover> cover;

  Album({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
    required this.artists,
    required this.cover,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      type: json['type'],
      id: json['id'],
      name: json['name'],
      shareUrl: json['shareUrl'],
      artists: (json['artists'] as List)
          .map((artistJson) => Artist.fromJson(artistJson))
          .toList(),
      cover: (json['cover'] as List)
          .map((coverJson) => Cover.fromJson(coverJson))
          .toList(),
    );
  }
}

class Cover {
  final String url;
  final int width;
  final int height;

  Cover({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class Playlist {
  final String addedAt;
  final dynamic addedBy;

  Playlist({
    required this.addedAt,
    required this.addedBy,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      addedAt: json['addedAt'],
      addedBy: json['addedBy'],
    );
  }
}

class JsonResponse {
  final bool status;
  final String errorId;
  final Contents contents;

  JsonResponse({
    required this.status,
    required this.errorId,
    required this.contents,
  });

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(
      status: json['status'],
      errorId: json['errorId'],
      contents: Contents.fromJson(json['contents']),
    );
  }
}

class Contents {
  final int totalCount;
  final List<Track> items;

  Contents({
    required this.totalCount,
    required this.items,
  });

  factory Contents.fromJson(Map<String, dynamic>? json) {
    return Contents(
      totalCount: json?['totalCount'],
      items: (json?['items'] as List)
          .map((itemJson) => Track.fromJson(itemJson))
          .toList(),
    );
  }
}

class Content {
  final List<Track>? items;
  final int? totalCount;

  Content.fromJSON(Map<String, dynamic>? json)
      : totalCount = json?['totalCount'],
        items = json?['items']
            ?.map((a) => Track.fromJson(a))
            .toList()
            .cast<Track>();

  Content({
    required this.items,
    required this.totalCount,
  });
}

class SpotifyPlaylist {
  final Content? content;

  SpotifyPlaylist.fromJSON(Map<String, dynamic>? json)
      : content = Content.fromJSON(json?['contents']);

  SpotifyPlaylist({
    required this.content,
  });
}
