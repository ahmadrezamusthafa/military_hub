import 'package:json_annotation/json_annotation.dart';

part 'update_user_location_model.g.dart';

@JsonSerializable()
class UpdateUserLocationModel {
  String email;
  String password;
  double latitude;
  double longitude;

  UpdateUserLocationModel({
    this.email,
    this.password,
    this.latitude,
    this.longitude,
  });

  factory UpdateUserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserLocationModelToJson(this);
}
