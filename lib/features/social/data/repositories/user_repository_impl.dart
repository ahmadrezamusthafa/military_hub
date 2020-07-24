import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/datasources/database/user_db_repository.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_user_repository.dart';
import 'package:military_hub/features/social/data/models/database/user_db_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/create_account_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/get_userid_by_email_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_phone_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_pin_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_profile_model.dart';
import 'package:military_hub/features/social/domain/entities/action_result.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDbRepository userDbRepository;
  final MSEngineUserRepository msEngineUserRepository;

  UserRepositoryImpl({
    this.userDbRepository,
    this.msEngineUserRepository,
  });

  @override
  Future<User> getUser(String email, String password,
      {OnError errorCallBack}) async {
    User user;
    var response = await msEngineUserRepository
        .getUserInformationFull(email, password, errorCallBack: errorCallBack);
    if (response != null) {
      user = new User(
        email: response.email,
        name: response.name,
        userId: response.userId,
        address: response.address,
        gender: response.gender,
        profileStatus: response.profileStatus,
        profilePicture: response.profilePicture,
        occupation: response.occupation,
        education: response.education,
        password: password,
        phoneNumber: response.phoneNumber,
        birthDate: response.birthDate,
        apiToken: "generated_temporary",
        createdAt: DateTime.now().toString(),
      );

      var dbUser = await userDbRepository.getUser();
      if (dbUser != null) {
        if (dbUser.email == email) {
          //update
          userDbRepository.update(UserDbModel(
            email: user.email,
            name: user.name,
            password: user.password,
            userId: user.userId,
            profileStatus: user.profileStatus,
            profilePicture: user.profilePicture,
            occupation: user.occupation,
            education: user.education,
            address: user.address,
            phoneNumber: user.phoneNumber,
            gender: user.gender,
            apiToken: user.apiToken,
            birthDate: user.birthDate,
            createdAt: user.createdAt,
            updatedAt: DateTime.now().toString(),
          ));
        } else {
          //delete
          await userDbRepository.deleteAll();
          //insert
          userDbRepository.insert(UserDbModel(
            email: user.email,
            name: user.name,
            password: user.password,
            userId: user.userId,
            profileStatus: user.profileStatus,
            profilePicture: user.profilePicture,
            occupation: user.occupation,
            education: user.education,
            address: user.address,
            phoneNumber: user.phoneNumber,
            gender: user.gender,
            apiToken: user.apiToken,
            birthDate: user.birthDate,
            createdAt: DateTime.now().toString(),
          ));
        }
      } else {
        //insert
        userDbRepository.insert(UserDbModel(
          email: user.email,
          name: user.name,
          password: user.password,
          userId: user.userId,
          profileStatus: user.profileStatus,
          profilePicture: user.profilePicture,
          occupation: user.occupation,
          education: user.education,
          address: user.address,
          phoneNumber: user.phoneNumber,
          gender: user.gender,
          apiToken: user.apiToken,
          birthDate: user.birthDate,
          createdAt: DateTime.now().toString(),
        ));
      }
    }
    return user;
  }

  @override
  Future<ActionResult> createNewUser(String email, String password, String name,
      String birthDate, String address, String phoneNumber) async {
    ActionResult result;
    CreateAccountModel param = new CreateAccountModel(
      email: email,
      password: password,
      name: name,
      birthDate: birthDate,
      phoneNumber: phoneNumber,
      address: address,
    );
    var response = await msEngineUserRepository.createNewUser(param);
    if (response != null) {
      result = ActionResult(
        isSuccess: response.isSuccess,
        message: response.message,
      );
    } else {
      result = ActionResult(
        isSuccess: false,
        message: "Invalid response",
      );
    }
    return result;
  }

  @override
  Future<List<String>> getUserIdByEmailList(
      String email, String password, List<String> emailList) async {
    List<String> userIdList = List<String>();
    GetUserIdByEmailModel param = new GetUserIdByEmailModel(
      email: email,
      password: password,
      emailList: emailList,
    );
    var responses = await msEngineUserRepository.getUserIdByEmailList(param);
    if (responses != null && responses.isNotEmpty) {
      for (var userId in responses) {
        userIdList.add(userId.userId);
      }
    }
    return userIdList;
  }

  @override
  Future<ActionResult> updateUserPIN(
      String email, String password, String pin) async {
    ActionResult result;
    UpdateUserPINModel param = new UpdateUserPINModel(
      email: email,
      password: password,
      pin: pin,
    );
    var response = await msEngineUserRepository.updateUserPIN(param);
    if (response != null) {
      result = ActionResult(
        isSuccess: response.isSuccess,
        message: response.message,
      );
    } else {
      result = ActionResult(
        isSuccess: false,
        message: "Invalid response",
      );
    }
    return result;
  }

  @override
  Future<ActionResult> updateUserPhone(
      String email, String phone, String verificationCode) async {
    ActionResult result;
    UpdateUserPhoneModel param = new UpdateUserPhoneModel(
      email: email,
      phone: phone,
      verificationCode: verificationCode,
    );
    var response = await msEngineUserRepository.updateUserPhone(param);
    if (response != null) {
      result = ActionResult(
        isSuccess: response.isSuccess,
        message: response.message,
      );
    } else {
      result = ActionResult(
        isSuccess: false,
        message: "Invalid response",
      );
    }
    return result;
  }

  @override
  Future<ActionResult> updateUserProfile(
      String email,
      String password,
      String name,
      String address,
      String birthDate,
      String education,
      String occupation,
      String profileStatus) async {
    ActionResult result;
    UpdateUserProfileModel param = new UpdateUserProfileModel(
      email: email,
      password: password,
      address: address,
      birthDate: birthDate,
      name: name,
      education: education,
      occupation: occupation,
      profileStatus: profileStatus,
    );
    var response = await msEngineUserRepository.updateUserProfile(param);
    if (response != null) {
      result = ActionResult(
        isSuccess: response.isSuccess,
        message: response.message,
      );
    } else {
      result = ActionResult(
        isSuccess: false,
        message: "Invalid response",
      );
    }
    return result;
  }

  @override
  Future<bool> checkUserLocalDbExists() async {
    var dbUser = await userDbRepository.getUser();
    if (dbUser != null) {
      if (dbUser.email != null &&
          dbUser.email != "" &&
          dbUser.userId != null &&
          dbUser.userId != "") {
        return true;
      }
    }
    return false;
  }
}
