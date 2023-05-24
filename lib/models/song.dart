import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song{
  Song({this.trackId, this.artistName, this.trackName, this.collectionName, this.previewUrl, this.artworkUrl100, this.releaseDate});
  int? trackId;
  String? artistName;
  String? trackName;
  String? collectionName;
  String? previewUrl;
  String? artworkUrl100;
  String? releaseDate;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SongToJson(this);
}