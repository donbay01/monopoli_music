class AudioApiResponse {
  final String? title;
  final String? artist;
  final String? album;
  final String? cover;
  final String? releaseDate;
  final String? downloadLink;
  // final bool status;
  // final String errorId;
  // final YoutubeVideo youtubeVideo;

  AudioApiResponse({
    this.album,
    this.artist,
    this.cover,
    this.downloadLink,
    this.releaseDate,
    this.title,
    // required this.status,
    // required this.errorId,
    // required this.youtubeVideo,
  });

  factory AudioApiResponse.fromJson(Map<String, dynamic> json) {
    return AudioApiResponse(
      album: json['album'],
      artist: json['artist'],
      cover: json['cover'],
      downloadLink: json['downloadLink'],
      title: json['title'],
      releaseDate: json['releaseDate'],
      // status: json['status'],
      // errorId: json['errorId'],
      // youtubeVideo: YoutubeVideo.fromJson(json['youtubeVideo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'cover': cover,
      'releaseDate': releaseDate,
      'downloadLink': downloadLink,
      // 'status': status,
      // 'errorId': errorId,
      // 'youtubeVideo': youtubeVideo.toJson(),
    };
  }
}

class YoutubeVideo {
  final String searchTerm;
  final String id;
  final String title;
  final Channel channel;
  final List<Audio> audio;

  YoutubeVideo({
    required this.searchTerm,
    required this.id,
    required this.title,
    required this.channel,
    required this.audio,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      searchTerm: json['searchTerm'],
      id: json['id'],
      title: json['title'],
      channel: Channel.fromJson(json['channel']),
      audio:
          (json['audio'] as List).map((item) => Audio.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'searchTerm': searchTerm,
      'id': id,
      'title': title,
      'channel': channel.toJson(),
      'audio': audio.map((item) => item.toJson()).toList(),
    };
  }
}

class Channel {
  final String id;
  final String name;
  final bool isVerified;
  final bool isVerifiedArtist;

  Channel({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.isVerifiedArtist,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      isVerified: json['isVerified'],
      isVerifiedArtist: json['isVerifiedArtist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isVerified': isVerified,
      'isVerifiedArtist': isVerifiedArtist,
    };
  }
}

class Audio {
  final String url;
  final int durationMs;
  final String durationText;
  final String mimeType;
  final String format;
  final int lastModified;
  final int size;
  final String sizeText;

  Audio({
    required this.url,
    required this.durationMs,
    required this.durationText,
    required this.mimeType,
    required this.format,
    required this.lastModified,
    required this.size,
    required this.sizeText,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      url: json['url'],
      durationMs: json['durationMs'],
      durationText: json['durationText'],
      mimeType: json['mimeType'],
      format: json['format'],
      lastModified: json['lastModified'],
      size: json['size'],
      sizeText: json['sizeText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'durationMs': durationMs,
      'durationText': durationText,
      'mimeType': mimeType,
      'format': format,
      'lastModified': lastModified,
      'size': size,
      'sizeText': sizeText,
    };
  }
}
