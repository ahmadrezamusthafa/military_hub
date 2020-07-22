import 'package:json_annotation/json_annotation.dart';

part 'get_friend_request_list_model.g.dart';

@JsonSerializable()
class GetFriendRequestListModel {
  String userId;
  String email;
  String name;
  String requestStatus;
  bool isFriend;

  GetFriendRequestListModel({
    this.userId,
    this.email,
    this.name,
    this.requestStatus,
    this.isFriend,
  });

  factory GetFriendRequestListModel.fromJson(Map<String, dynamic> json) =>
      _$GetFriendRequestListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFriendRequestListModelToJson(this);
}
