// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_information_for_friend_invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInformationForFriendInvitationModel
    _$GetInformationForFriendInvitationModelFromJson(
        Map<String, dynamic> json) {
  return GetInformationForFriendInvitationModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    sentStatus: json['sentStatus'] as String,
    deliveredStatus: json['deliveredStatus'] as String,
  );
}

Map<String, dynamic> _$GetInformationForFriendInvitationModelToJson(
        GetInformationForFriendInvitationModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'sentStatus': instance.sentStatus,
      'deliveredStatus': instance.deliveredStatus,
    };
