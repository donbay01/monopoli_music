import 'contents.dart';

class Item {
  final String? type;
  final String? id;
  final String? title;
  final String? shareUrl;
  final Contents? contents;

  Item.fromJSON(Map<String, dynamic> json)
      : type = json['type'],
        id = json['id'],
        title = json['title'],
        shareUrl = json['shareUrl'],
        contents = Contents.fromJSON(json['contents']);

  Item({
    this.type,
    this.id,
    this.title,
    this.shareUrl,
    this.contents,
  });
}

class Section {
  final int? totalCount;
  final List<Item>? items;

  Section.fromJSON(Map<String, dynamic> json)
      : totalCount = json['totalCount'],
        items =
            json['items']?.map((a) => Item.fromJSON(a)).toList().cast<Item>();

  Section({
    this.totalCount,
    this.items,
  });
}
