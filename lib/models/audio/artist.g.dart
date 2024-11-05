// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artists _$ArtistsFromJson(Map<String, dynamic> json) => Artists(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      type: json['type'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      shareUrl: json['shareUrl'] as String?,
      verified: json['verified'] as bool?,
      visuals: json['visuals'] == null
          ? null
          : Visuals.fromJson(json['visuals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'shareUrl': instance.shareUrl,
      'verified': instance.verified,
      'visuals': instance.visuals,
    };
