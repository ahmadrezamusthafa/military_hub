import 'package:json_annotation/json_annotation.dart';

import 'member_email_model.dart';

part 'create_group_member_model.g.dart';

@JsonSerializable()
class CreateGroupMemberModel {
  String kodeGroup;
  List<MemberEmailModel> userEmail;

  CreateGroupMemberModel({
    this.kodeGroup,
    this.userEmail,
  });

  factory CreateGroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupMemberModelToJson(this);
}
