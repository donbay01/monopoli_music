// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracks _$TracksFromJson(Map<String, dynamic> json) => Tracks(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TracksToJson(Tracks instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      type: json['type'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      shareUrl: json['shareUrl'] as String,
      explicit: json['explicit'] as bool,
      durationMs: (json['durationMs'] as num).toInt(),
      durationText: json['durationText'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: Album.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'shareUrl': instance.shareUrl,
      'explicit': instance.explicit,
      'durationMs': instance.durationMs,
      'durationText': instance.durationText,
      'artists': instance.artists,
      'album': instance.album,
    };
