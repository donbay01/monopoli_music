// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genres _$GenresFromJson(Map<String, dynamic> json) => Genres(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenresToJson(Genres instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      type: json['type'] as String,
      id: json['id'] as String,
      title: json['title'] as String,
      shareUrl: json['shareUrl'] as String,
      image: (json['image'] as List<dynamic>)
          .map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'title': instance.title,
      'shareUrl': instance.shareUrl,
      'image': instance.image,
    };
