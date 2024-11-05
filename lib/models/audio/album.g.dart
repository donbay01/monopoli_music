// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      type: json['type'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      shareUrl: json['shareUrl'] as String?,
      date: json['date'] as String?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      cover: (json['cover'] as List<dynamic>?)
          ?.map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'shareUrl': instance.shareUrl,
      'date': instance.date,
      'artists': instance.artists?.map((a) => a.toJson()).toList(),
      'cover': instance.cover?.map((a) => a.toJson()).toList(),
      'content': instance.content?.toJson(),
    };
