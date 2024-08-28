import 'package:monopoli/models/audio/visuals.dart';

class Avatar {
  final String? url;
  final int? width;
  final int? height;

  Avatar.fromJSON(Map<String, dynamic> json)
      : url = json['url'],
        width = json['width'],
        height = json['height'];

  Avatar({this.url, this.width, this.height});
}

class Visuals {
  final List<Avatar>? avatar;

  Visuals.fromJSON(Map<String, dynamic>? json)
      : avatar = json?['avatar']
            .map((a) => Avatar.fromJSON(a))
            .toList()
            .cast<Avatar>();

  Visuals({this.avatar});
}

class Item {
  final String? type;
  final String? id;
  final String? name;
  final String? shareUrl;
  final Visuals? visuals;

  Item.fromJSON(Map<String, dynamic> json)
      : type = json['type'],
        id = json['id'],
        name = json['name'],
        shareUrl = json['shareUrl'],
        visuals = Visuals.fromJSON(json['visuals']);

  Item({
    this.type,
    this.id,
    this.name,
    this.shareUrl,
    required this.visuals,
  });
}

class Contents {
  final List<Item>? items;

  Contents.fromJSON(Map<String, dynamic>? json)
      : items =
            json?['items'].map((a) => Item.fromJSON(a)).toList().cast<Item>();

  Contents({this.items});
}
