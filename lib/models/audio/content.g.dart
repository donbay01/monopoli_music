// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      type: json['type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      shareUrl: json['shareUrl'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      cover: (json['cover'] as List<dynamic>)
          .map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'shareUrl': instance.shareUrl,
      'artists': instance.artists,
      'cover': instance.cover,
    };
