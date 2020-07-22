import 'package:json_annotation/json_annotation.dart';

part 'get_friend_request_count_model.g.dart';

@JsonSerializable()
class GetFriendRequestCountModel {
  int requestCount;

  GetFriendRequestCountModel({
    this.requestCount,
  });

  factory GetFriendRequestCountModel.fromJson(Map<String, dynamic> json) =>
      _$GetFriendRequestCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFriendRequestCountModelToJson(this);
}
