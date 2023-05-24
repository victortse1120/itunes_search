// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      trackId: json['trackId'] as int?,
      artistName: json['artistName'] as String?,
      trackName: json['trackName'] as String?,
      collectionName: json['collectionName'] as String?,
      previewUrl: json['previewUrl'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
      releaseDate: json['releaseDate'] as String?,
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
