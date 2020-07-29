import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/create_post_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/api_result_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_feeds_result_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/status_result_model.dart';

class MSEngineFeedsRepository {
  MSEngineFeedsRepository();

  Future<List<GetFeedsResultModel>> getFeeds(
      String email, String password, int page, int limit,
      {OnError errorCallBack}) async {
    List<GetFeedsResultModel> feedsList = new List<GetFeedsResultModel>();
    try {
      var params = Map<String, dynamic>();
      params['Email'] = email;
      params['Password'] = password;
      params['Page'] = page;
      params['Limit'] = limit;
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Feeds/GetFeeds",
          params: params);
      var apiResult = APIResultModel.fromJson(response);
      if (apiResult.result != null && apiResult.result.length > 0) {
        for (var item in apiResult.result) {
          var value = GetFeedsResultModel.fromJson(item);
          feedsList.add(new GetFeedsResultModel(
            userId: value.userId,
            name: value.name,
            latitude: value.latitude,
            longitude: value.longitude,
            image: value.image,
            locationName: value.locationName,
            profilePicture: value.profilePicture,
            isLiked: value.isLiked,
            commentCount: value.commentCount,
            likeCount: value.likeCount,
            description: value.description,
            postCode: value.postCode,
            type: value.type,
            userLatitude: value.userLatitude,
            userLongitude: value.userLongitude,
            createdAt: value.createdAt,
          ));
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return feedsList;
  }

  Future<StatusResultModel> createPost(CreatePostModel param) async {
    StatusResultModel result;
    try {
      var params = param.toJson();
      var response = await HttpRequest.getInstance().postWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Feeds/CreateFeeds",
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
}
