import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/api_result_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_feeds_result_model.dart';

class MSEngineFeedsRepository {
  MSEngineFeedsRepository();

  Future<List<GetFeedsResultModel>> getFeeds(
      String email, String password, int page, int limit,
      {OnError errorCallBack}) async {
    List<GetFeedsResultModel> feedsList = new List<GetFeedsResultModel>();

    /*for (int i = 0; i < 15; i++) {
      feedsList.add(GetFeedsResultModel(
        postCode: Uuid().toString(),
        type: 0,
        description:
            "Hello, ada kemacetan jalan yang disebabkan oleh kerumunan masa yang sedang demo ada kemacetan. Hello, ada kemacetan jalan yang disebabkan oleh kerumunan masa yang sedang demo",
        userId: "ACM_1",
        name: "Yovi Arsyad",
        profilePicture: Helper.getImageUrlByIdNumber(1),
        likeCount: 12,
        commentCount: 1,
        isLiked: false,
        createdAt: DateTime.now().toString(),
      ));

      feedsList.add(GetFeedsResultModel(
        postCode: Uuid().toString(),
        type: 1,
        image:
            "https://rajaampatbiodiversity.com/wp-content/uploads/2019/06/visitar-raja-ampat.jpg",
        description: "Raja ampat bagus sekali ya..",
        userId: "ACM_1",
        name: "Yovi Arsyad",
        profilePicture: Helper.getImageUrlByIdNumber(1),
        likeCount: 2,
        commentCount: 0,
        isLiked: false,
        createdAt: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day - 1)
            .toString(),
      ));

      feedsList.add(GetFeedsResultModel(
        postCode: Uuid().toString(),
        type: 0,
        description: "Lapor, jalan arjuna clear",
        userId: "ACM_2",
        name: "Budi Waseso",
        profilePicture: Helper.getImageUrlByIdNumber(2),
        createdAt: DateTime.now().toString(),
      ));

      feedsList.add(GetFeedsResultModel(
        postCode: Uuid().toString(),
        type: 3,
        latitude: "-7.545449647437256",
        longitude: "112.46844716370106",
        locationName: "Jalan Arjuna 78",
        description: "Lapor, jalan arjuna clear",
        userId: "ACM_2",
        name: "Budi Waseso",
        profilePicture: Helper.getImageUrlByIdNumber(2),
        createdAt: DateTime.now().toString(),
      ));

      feedsList.add(GetFeedsResultModel(
        postCode: Uuid().toString(),
        type: 3,
        latitude: "-7.545449647437256",
        longitude: "112.46844716370106",
        locationName: "Jalan Malioboro 718 Surabaya",
        userId: "ACM_2",
        name: "Budi Waseso",
        profilePicture: Helper.getImageUrlByIdNumber(2),
        createdAt: "2020-01-01 12:00:22",
      ));
    }*/
    try {
      var params = Map<String, dynamic>();
      params['Email'] = email;
      params['Password'] = password;
      params['Page'] = page;
      params['Limit'] = limit;
      var response = await HttpRequest.getInstance().getWithoutCallBack(
          API.MSEngineAPIUrl + "/api/Channel/GetFeeds",
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
            createdAt: value.createdAt,
          ));
        }
      }
    } catch (e) {
      print("Got error: ${e.toString()}");
    }
    return feedsList;
  }
}
