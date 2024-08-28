class SpotifySection {
  final bool status;
  final String errorId;
  final String type;
  final String id;
  final String title;
  final String shareUrl;
  final Contents contents;

  SpotifySection({
    required this.status,
    required this.errorId,
    required this.type,
    required this.id,
    required this.title,
    required this.shareUrl,
    required this.contents,
  });

  factory SpotifySection.fromJson(Map<String, dynamic> json) {
    return SpotifySection(
      status: json['status'],
      errorId: json['errorId'],
      type: json['type'],
      id: json['id'],
      title: json['title'],
      shareUrl: json['shareUrl'],
      contents: Contents.fromJson(json['contents']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'errorId': errorId,
      'type': type,
      'id': id,
      'title': title,
      'shareUrl': shareUrl,
      'contents': contents.toJson(),
    };
  }
}

class Contents {
  final int totalCount;
  final List<Playlist> items;

  Contents({
    required this.totalCount,
    required this.items,
  });

  factory Contents.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Playlist> playlistList =
        list.map((i) => Playlist.fromJson(i)).toList();

    return Contents(
      totalCount: json['totalCount'],
      items: playlistList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}

class Playlist {
  final String type;
  final String id;
  final String name;
  final String shareUrl;
  final String description;
  final Owner owner;
  final List<List<Image>> images;

  Playlist({
    required this.type,
    required this.id,
    required this.name,
    required this.shareUrl,
    required this.description,
    required this.owner,
    required this.images,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    var imagesList = (json['images'] as List)
        .map((item) => (item as List).map((i) => Image.fromJson(i)).toList())
        .toList();

    return Playlist(
      type: json['type'],
      id: json['id'],
      name: json['name'],
      shareUrl: json['shareUrl'],
      description: json['description'],
      owner: Owner.fromJson(json['owner']),
      images: imagesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'name': name,
      'shareUrl': shareUrl,
      'description': description,
      'owner': owner.toJson(),
      'images':
          images.map((list) => list.map((i) => i.toJson()).toList()).toList(),
    };
  }
}

class Owner {
  final String type;
  final String name;

  Owner({
    required this.type,
    required this.name,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      type: json['type'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
    };
  }
}

class Image {
  final String url;
  final int? width;
  final int? height;

  Image({
    required this.url,
    this.width,
    this.height,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }
}
