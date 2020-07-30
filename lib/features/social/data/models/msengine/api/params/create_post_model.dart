import 'package:json_annotation/json_annotation.dart';

part 'create_post_model.g.dart';

@JsonSerializable()
class CreatePostModel {
  String userId;
  String description;
  String image;
  String latitude;
  String longitude;
  String locationName;
  int type;

  CreatePostModel({
    this.userId,
    this.description,
    this.image,
    this.latitude,
    this.longitude,
    this.locationName,
    this.type,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);
}
