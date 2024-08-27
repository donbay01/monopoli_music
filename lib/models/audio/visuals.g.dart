// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visuals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visuals _$VisualsFromJson(Map<String, dynamic> json) => Visuals(
      avatar: (json['avatar'] as List<dynamic>?)
          ?.map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisualsToJson(Visuals instance) => <String, dynamic>{
      'avatar': instance.avatar,
    };
