import 'package:json_annotation/json_annotation.dart';

part 'get_information_for_friend_invitation_model.g.dart';

@JsonSerializable()
class GetInformationForFriendInvitationModel {
  String userId;
  String email;
  String name;
  String sentStatus;
  String deliveredStatus;

  GetInformationForFriendInvitationModel({
    this.userId,
    this.email,
    this.name,
    this.sentStatus,
    this.deliveredStatus,
  });

  factory GetInformationForFriendInvitationModel.fromJson(
          Map<String, dynamic> json) =>
      _$GetInformationForFriendInvitationModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetInformationForFriendInvitationModelToJson(this);
}
