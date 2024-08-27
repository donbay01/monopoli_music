import 'package:json_annotation/json_annotation.dart';
import 'cover.dart';
part 'visuals.g.dart';

@JsonSerializable()
class Visuals {
  final List<Cover>? avatar;

  Visuals({this.avatar});

  factory Visuals.fromJson(Map<String, dynamic> json) =>
      _$VisualsFromJson(json);

  Map<String, dynamic> toJson() => _$VisualsToJson(this);
}
