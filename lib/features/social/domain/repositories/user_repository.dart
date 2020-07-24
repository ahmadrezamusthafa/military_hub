import 'package:flutter/cupertino.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/domain/entities/action_result.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

abstract class UserRepository {
  Future<User> getUser(String email, String password, {OnError errorCallBack});

  Future<List<String>> getUserIdByEmailList(
      String email, String password, List<String> emailList);

  Future<ActionResult> createNewUser(String email, String password, String name,
      String birthDate, String address, String phoneNumber);

  Future<ActionResult> updateUserProfile(
      String email,
      String password,
      String name,
      String address,
      String birthDate,
      String education,
      String occupation,
      String profileStatus);

  Future<ActionResult> updateUserPIN(String email, String password, String pin);

  Future<ActionResult> updateUserPhone(
      String email, String phone, String verificationCode);

  Future<bool> checkUserLocalDbExists();
}
