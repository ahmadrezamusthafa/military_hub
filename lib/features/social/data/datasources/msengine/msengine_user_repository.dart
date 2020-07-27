import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/create_account_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/get_userid_by_email_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_phone_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_pin_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_profile_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/api_result_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_user_information_by_radius_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_user_information_full_by_phone_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_user_information_full_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_userid_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/status_result_model.dart';
import 'package:military_hub/helpers/helper.dart';

class MSEngineUserRepository {
  MSEngineUserRepository();

  Future<GetUserInformationFullModel> getUserInformationFull(
      String email, password,
      {OnError errorCallBack}) async {
    GetUserInformationFullModel user;
    try {
      var params = Map<String, String>();
      params['Email'] = email;
      params['Password'] = password;
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/GetUserInformationFull",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          user = GetUserInformationFullModel.fromJson(item);
          break;
        }
      } else {
        if (apiResult.error != null && apiResult.error != "") {
          errorCallBack(apiResult.error, 500);
        } else {
          errorCallBack("Unexpected error", 500);
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
      errorCallBack("Unexpected error", 500);
    }
    return user;
  }

  Future<GetUserInformationFullByPhoneModel> getUserInformationFullByPhone(
      String phone, verificationCode) async {
    GetUserInformationFullByPhoneModel user;
    try {
      var params = Map<String, String>();
      params['Phone'] = phone;
      params['VerificationCode'] = verificationCode;
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/GetUserInformationFullByPhone",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          user = GetUserInformationFullByPhoneModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return user;
  }

  Future<List<GetUserIdModel>> getUserIdByEmailList(
      GetUserIdByEmailModel param) async {
    List<GetUserIdModel> userIds = List<GetUserIdModel>();
    try {
      var params = param.toJson();
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/GetUserIdByEmailList",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          var value = GetUserIdModel.fromJson(item);
          userIds.add(new GetUserIdModel(userId: value.userId));
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return userIds;
  }

  Future<StatusResultModel> createNewUser(CreateAccountModel param) async {
    StatusResultModel result;
    try {
      var params = param.toJson();
      var response = await HttpRequest.getInstance().postWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/CreateAccount",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return result;
  }

  Future<StatusResultModel> updateUserProfile(
      UpdateUserProfileModel param) async {
    StatusResultModel result;
    try {
      var params = param.toJson();
      var response = await HttpRequest.getInstance().postWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/UpdateUserProfile",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return result;
  }

  Future<StatusResultModel> updateUserPIN(UpdateUserPINModel param) async {
    StatusResultModel result;
    try {
      var params = param.toJson();
      var response = await HttpRequest.getInstance().postWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/UpdateUserPIN",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return result;
  }

  Future<StatusResultModel> updateUserPhone(UpdateUserPhoneModel param) async {
    StatusResultModel result;
    try {
      var params = param.toJson();
      var response = await HttpRequest.getInstance().postWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/UpdateUserPhone",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return result;
  }

  Future<List<GetUserRangeInformationByRadiusModel>> getNearUserList(
      String email, String password, double latitude, double longitude,
      {int radius, OnError errorCallBack}) async {
    List<GetUserRangeInformationByRadiusModel> userList =
        new List<GetUserRangeInformationByRadiusModel>();

    /*userList.add(GetUserRangeInformationByRadiusModel(
      userId: "ACM_1",
      name: "Yovi Arsyad",
      profilePicture: Helper.getImageUrlByIdNumber(1),
      email: "altraz@yahoo.com",
      latitude: "-7.545449647437256",
      longitude: "112.46844716370106",
    ));

    userList.add(GetUserRangeInformationByRadiusModel(
      userId: "ACM_2",
      name: "Budi Waseso",
      profilePicture: Helper.getImageUrlByIdNumber(2),
      email: "budi@yahoo.com",
      latitude: "-7.512449647437256",
      longitude: "112.45544716370106",
    ));

    userList.add(GetUserRangeInformationByRadiusModel(
      userId: "ACM_34",
      name: "Andi Waseso",
      profilePicture: Helper.getImageUrlByIdNumber(34),
      email: "andi@yahoo.com",
      latitude: "-7.545449647437256",
      longitude: "112.45844716370106",
    ));

    userList.add(GetUserRangeInformationByRadiusModel(
      userId: "ACM_3",
      name: "Ahmad Reza Musthafa",
      profilePicture: Helper.getImageUrlByIdNumber(3),
      email: "andi@yahoo.com",
      latitude: "-7.345449647437256",
      longitude: "112.4744716370106",
      isPublisher: true,
    ));*/

    try {
      var params = Map<String, dynamic>();
      params['Email'] = email;
      params['Password'] = password;
      params['Latitude'] = latitude;
      params['Longitude'] = longitude;
      params['Radius'] = radius;
      params['Apps'] = API.AppsInitial;
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/GetNearUserByRadius",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          var value = GetUserRangeInformationByRadiusModel.fromJson(item);
          userList.add(new GetUserRangeInformationByRadiusModel(
            userId: value.userId,
            name: value.name,
            latitude: value.latitude,
            longitude: value.longitude,
            profilePicture: value.profilePicture,
            email: value.email,
            address: value.address,
            isPublisher: false,
          ));
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return userList;
  }
}
