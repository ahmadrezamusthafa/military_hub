import 'package:military_hub/features/social/domain/entities/action_result.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository repository;

  UserUseCase(this.repository);

  Future<User> getUser(String username, String password) async {
    return await repository.getUser(username, password);
  }

  Future<List<String>> getUserIdByEmailList(
      String email, String password, List<String> emailList) async {
    return await repository.getUserIdByEmailList(email, password, emailList);
  }

  Future<ActionResult> createNewUser(String email, String password, String name,
      String birthDate, String address, String phoneNumber) async {
    return await repository.createNewUser(
      email,
      password,
      name,
      birthDate,
      address,
      phoneNumber,
    );
  }

  Future<ActionResult> updateUserProfile(
      String email,
      String password,
      String name,
      String address,
      String birthDate,
      String education,
      String occupation,
      String profileStatus) async {
    return await repository.updateUserProfile(
      email,
      password,
      name,
      address,
      birthDate,
      education,
      occupation,
      profileStatus,
    );
  }

  Future<ActionResult> updateUserPIN(
      String email, String password, String pin) async {
    return await repository.updateUserPIN(
      email,
      password,
      pin,
    );
  }

  Future<ActionResult> updateUserPhone(
      String email, String phone, String verificationCode) async {
    return await repository.updateUserPhone(
      email,
      phone,
      verificationCode,
    );
  }

  Future<bool> checkUserLocalDbExists() async {
    return repository.checkUserLocalDbExists();
  }
}
