import 'package:json_annotation/json_annotation.dart';
part 'cover.g.dart';

@JsonSerializable()
class Cover {
  final String url;
  final int width;
  final int height;

  Cover({required this.url, required this.width, required this.height});

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);

  Map<String, dynamic> toJson() => _$CoverToJson(this);
}
