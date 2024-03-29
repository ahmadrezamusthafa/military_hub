import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/datasources/database/user_db_repository.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_user_repository.dart';
import 'package:military_hub/features/social/data/models/database/user_db_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/create_account_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/get_userid_by_email_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_location_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_phone_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_pin_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_profile_model.dart';
import 'package:military_hub/features/social/domain/entities/action_result.dart';
import 'package:military_hub/features/social/domain/entities/near_user.dart';
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
  Future<ActionResult> updateUserLocation(
      String email, String password, double latitude, double longitude) async {
    ActionResult result;
    UpdateUserLocationModel param = new UpdateUserLocationModel(
      email: email,
      password: password,
      latitude: latitude,
      longitude: longitude,
    );
    var response = await msEngineUserRepository.updateUserLocation(param);
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

  @override
  Future<bool> deleteUserDb() async {
    await userDbRepository.deleteAll();
    return true;
  }

  @override
  Future<User> getUserLocalDb() async {
    User user;
    var dbUser = await userDbRepository.getUser();
    if (dbUser != null) {
      user = new User(
        email: dbUser.email,
        name: dbUser.name,
        userId: dbUser.userId,
        address: dbUser.address,
        gender: dbUser.gender,
        profileStatus: dbUser.profileStatus,
        profilePicture: dbUser.profilePicture,
        occupation: dbUser.occupation,
        education: dbUser.education,
        password: dbUser.password,
        phoneNumber: dbUser.phoneNumber,
        birthDate: dbUser.birthDate,
        apiToken: dbUser.apiToken,
        latitude: dbUser.latitude,
        longitude: dbUser.longitude,
        createdAt: dbUser.createdAt,
      );
    }
    return user;
  }

  @override
  setCurrentUser(User user) {
    currentUser.value.userId = user.userId ?? "";
    currentUser.value.name = user.name ?? "";
    currentUser.value.email = user.email ?? "";
    currentUser.value.password = user.password;
    currentUser.value.phoneNumber = user.phoneNumber ?? "";
    currentUser.value.profileStatus = user.profileStatus ?? "";
    currentUser.value.profilePicture = user.profilePicture ?? "";
    currentUser.value.address = user.address ?? "";
    currentUser.value.apiToken = user.apiToken ?? "";
    currentUser.value.birthDate = user.birthDate ?? "";
    currentUser.value.latitude = user.latitude ?? 0;
    currentUser.value.longitude = user.longitude ?? 0;
  }

  @override
  Future<List<NearUser>> getNearUserList(
      String email, String password, double latitude, double longitude,
      {int radius, OnError errorCallBack}) async {
    List<NearUser> userList = List<NearUser>();
    var responses = await msEngineUserRepository.getNearUserList(
        email, password, latitude, longitude,
        radius: radius, errorCallBack: errorCallBack);
    if (responses != null && responses.isNotEmpty) {
      for (var resp in responses) {
        userList.add(NearUser(
          userId: resp.userId ?? "",
          email: resp.email ?? "",
          name: resp.name ?? "",
          profilePicture: resp.profilePicture ?? "",
          address: resp.address ?? "",
          latitude: resp.latitude ?? "",
          longitude: resp.longitude ?? "",
          isPublisher: resp.isPublisher ?? false,
        ));
      }
    }
    return userList;
  }

  @override
  Future updateUserLocationLocalDb(double latitude, double longitude) async {
    var dbUser = await userDbRepository.getUser();
    if (dbUser != null) {
      dbUser.latitude = latitude;
      dbUser.longitude = longitude;

      userDbRepository.update(dbUser);
    }
  }
}
