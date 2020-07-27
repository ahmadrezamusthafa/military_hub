import 'package:json_annotation/json_annotation.dart';

part 'get_user_information_by_radius_model.g.dart';

@JsonSerializable()
class GetUserRangeInformationByRadiusModel {
  String userId;
  String email;
  String name;
  String address;
  String profilePicture;
  String latitude;
  String longitude;
  bool isPublisher;

  GetUserRangeInformationByRadiusModel({
    this.userId,
    this.email,
    this.name,
    this.address,
    this.profilePicture,
    this.latitude,
    this.longitude,
    this.isPublisher,
  });

  factory GetUserRangeInformationByRadiusModel.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserRangeInformationByRadiusModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetUserRangeInformationByRadiusModelToJson(this);
}
