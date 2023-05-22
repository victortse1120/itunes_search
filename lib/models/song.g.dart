// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      json['trackId'] as int,
      json['trackName'] as String,
      json['collectionName'] as String,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'trackId': instance.trackId,
      'trackName': instance.trackName,
      'collectionName': instance.collectionName,
    };
