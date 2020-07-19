import 'package:flutter/cupertino.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

abstract class UserRepository {
  Future<User> getUser(String email, String password);
}
