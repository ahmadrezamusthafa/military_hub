import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/get_feeds_model.dart';
import 'package:military_hub/features/social/data/models/msengine/api/results/get_feeds_result_model.dart';
import 'package:military_hub/helpers/helper.dart';
import 'package:uuid/uuid.dart';

class MSEngineFeedsRepository {
  MSEngineFeedsRepository();

  Future<List<GetFeedsResultModel>> getFeeds(GetFeedsModel param,
      {OnError errorCallBack}) async {
    List<GetFeedsResultModel> feedsList = new List<GetFeedsResultModel>();

    for (int i = 0; i < 15; i++) {
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
    }
    return feedsList;
  }
}
