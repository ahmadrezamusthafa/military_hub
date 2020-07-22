// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_friend_request_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFriendRequestListModel _$GetFriendRequestListModelFromJson(
    Map<String, dynamic> json) {
  return GetFriendRequestListModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    requestStatus: json['requestStatus'] as String,
    isFriend: json['isFriend'] as bool,
  );
}

Map<String, dynamic> _$GetFriendRequestListModelToJson(
        GetFriendRequestListModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'requestStatus': instance.requestStatus,
      'isFriend': instance.isFriend,
    };
