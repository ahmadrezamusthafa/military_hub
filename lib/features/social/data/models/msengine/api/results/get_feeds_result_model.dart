import 'package:json_annotation/json_annotation.dart';

part 'get_feeds_result_model.g.dart';

@JsonSerializable()
class GetFeedsResultModel {
  String postCode;
  int type;
  String image;
  String latitude;
  String longitude;
  String locationName;
  String description;
  String userId;
  String name;
  int likeCount;
  int commentCount;
  bool isLiked;
  String createdAt;

  GetFeedsResultModel({
    this.postCode,
    this.type,
    this.image,
    this.latitude,
    this.longitude,
    this.locationName,
    this.description,
    this.userId,
    this.name,
    this.likeCount,
    this.commentCount,
    this.isLiked,
    this.createdAt,
  });

  factory GetFeedsResultModel.fromJson(Map<String, dynamic> json) =>
      _$GetFeedsResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFeedsResultModelToJson(this);
}
