// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audiobooks _$AudiobooksFromJson(Map<String, dynamic> json) => Audiobooks(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Audiobook.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudiobooksToJson(Audiobooks instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

Audiobook _$AudiobookFromJson(Map<String, dynamic> json) => Audiobook(
      type: json['type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      shareUrl: json['shareUrl'] as String,
      date: json['date'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      cover: (json['cover'] as List<dynamic>)
          .map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudiobookToJson(Audiobook instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'shareUrl': instance.shareUrl,
      'date': instance.date,
      'authors': instance.authors,
      'cover': instance.cover,
    };
