// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupMemberModel _$CreateGroupMemberModelFromJson(
    Map<String, dynamic> json) {
  return CreateGroupMemberModel(
    kodeGroup: json['kodeGroup'] as String,
    userEmail: (json['userEmail'] as List)
        ?.map((e) => e == null
            ? null
            : MemberEmailModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CreateGroupMemberModelToJson(
        CreateGroupMemberModel instance) =>
    <String, dynamic>{
      'kodeGroup': instance.kodeGroup,
      'userEmail': instance.userEmail,
    };
