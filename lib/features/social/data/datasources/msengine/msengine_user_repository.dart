import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/create_account_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/get_userid_by_email_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_phone_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_pin_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/update_user_profile_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/api_result_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_user_information_full_by_phone_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_user_information_full_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_userid_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/status_result_model.dart';

class MSEngineUserRepository {
  MSEngineUserRepository();

  Future<GetUserInformationFullModel> getUserInformationFull(
      String email, password) async {
    GetUserInformationFullModel user;
    try {
      var params = Map<String, String>();
      params['Email'] = email;
      params['Password'] = password;
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Account/GetUserInformationFull",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          user = GetUserInformationFullModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.error}");
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
      print("Got error: ${e.error}");
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
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          var value = GetUserIdModel.fromJson(item);
          userIds.add(new GetUserIdModel(userId: value.userId));
        }
      }
    } catch (e) {
      print("Got error: ${e.error}");
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
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.error}");
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
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.error}");
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
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.error}");
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
      if (apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          result = StatusResultModel.fromJson(item);
          break;
        }
      }
    } catch (e) {
      print("Got error: ${e.error}");
    }
    return result;
  }
}
