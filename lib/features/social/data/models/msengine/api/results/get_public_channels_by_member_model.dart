import 'package:json_annotation/json_annotation.dart';

part 'get_public_channels_by_member_model.g.dart';

@JsonSerializable()
class GetPublicChannelsByMemberModel {
  String kodeCompany;
  String name;

  GetPublicChannelsByMemberModel({
    this.kodeCompany,
    this.name,
  });

  factory GetPublicChannelsByMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GetPublicChannelsByMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPublicChannelsByMemberModelToJson(this);
}
