import 'package:json_annotation/json_annotation.dart';

part 'get_public_channels_model.g.dart';

@JsonSerializable()
class GetPublicChannelsModel {
  String kodeChannel;
  String name;
  String kodeCompany;
  String profilePicture;
  String ownerId;
  int memberCount;

  GetPublicChannelsModel({
    this.kodeChannel,
    this.name,
    this.kodeCompany,
    this.profilePicture,
    this.ownerId,
    this.memberCount,
  });

  factory GetPublicChannelsModel.fromJson(Map<String, dynamic> json) =>
      _$GetPublicChannelsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPublicChannelsModelToJson(this);
}
