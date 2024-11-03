class SpotifyCategoryIcon {
  final int? height;
  final int? width;
  final String url;

  SpotifyCategoryIcon.fromJSON(Map<dynamic, dynamic> json)
      : height = json['height'],
        width = json['width'],
        url = json['url'];

  SpotifyCategoryIcon({
    this.height,
    this.width,
    required this.url,
  });
}

class SpotifyCategory {
  final String id;
  final String name;
  final List<SpotifyCategoryIcon> icons;

  SpotifyCategory.fromJSON(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        icons = json['icons']
            .map((a) => SpotifyCategoryIcon.fromJSON(a))
            .toList()
            .cast<SpotifyCategoryIcon>();

  SpotifyCategory({
    required this.id,
    required this.name,
    required this.icons,
  });
}
