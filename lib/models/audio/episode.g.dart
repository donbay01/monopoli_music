// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episodes _$EpisodesFromJson(Map<String, dynamic> json) => Episodes(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodesToJson(Episodes instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      type: json['type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      shareUrl: json['shareUrl'] as String,
      explicit: json['explicit'] as bool,
      date: json['date'] as String,
      description: json['description'] as String,
      durationMs: (json['durationMs'] as num).toInt(),
      durationText: json['durationText'] as String,
      paywallContent: json['paywallContent'] as bool,
      cover: (json['cover'] as List<dynamic>)
          .map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'shareUrl': instance.shareUrl,
      'explicit': instance.explicit,
      'date': instance.date,
      'description': instance.description,
      'durationMs': instance.durationMs,
      'durationText': instance.durationText,
      'paywallContent': instance.paywallContent,
      'cover': instance.cover,
    };
