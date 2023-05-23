// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      json['trackId'] as int?,
      json['artistName'] as String?,
      json['trackName'] as String?,
      json['collectionName'] as String?,
      json['previewUrl'] as String?,
      json['artworkUrl100'] as String?,
      json['releaseDate'] as String?,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'trackId': instance.trackId,
      'artistName': instance.artistName,
      'trackName': instance.trackName,
      'collectionName': instance.collectionName,
      'previewUrl': instance.previewUrl,
      'artworkUrl100': instance.artworkUrl100,
      'releaseDate': instance.releaseDate,
    };
