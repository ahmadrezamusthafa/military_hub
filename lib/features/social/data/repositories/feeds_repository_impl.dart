import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_feeds_repository.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/get_feeds_model.dart';
import 'package:military_hub/features/social/domain/entities/enums/post_type.dart';
import 'package:military_hub/features/social/domain/entities/post.dart';
import 'package:military_hub/features/social/domain/repositories/feeds_repository.dart';
import 'package:military_hub/helpers/helper.dart';

class FeedsRepositoryImpl implements FeedsRepository {
  final MSEngineFeedsRepository msEngineFeedsRepository;

  FeedsRepositoryImpl({
    this.msEngineFeedsRepository,
  });

  @override
  Future<List<Post>> getFeeds(
      String email, String password, int page, int limit,
      {OnError errorCallBack}) async {
    List<Post> feedsList = List<Post>();
    GetFeedsModel param = new GetFeedsModel(
      email: email,
      password: password,
      page: page,
      limit: limit,
    );

    var responses = await msEngineFeedsRepository.getFeeds(param,
        errorCallBack: errorCallBack);
    if (responses != null && responses.isNotEmpty) {
      for (var resp in responses) {
        feedsList.add(Post(
          postCode: resp.postCode ?? "",
          type: postTypeFromInt(resp.type),
          image: resp.image ?? "",
          location: Helper.getLatLngFromString(resp.latitude, resp.longitude),
          locationName: resp.locationName ?? "",
          description: resp.description ?? "",
          userId: resp.userId ?? "",
          likeCount: resp.likeCount ?? 0,
          commentCount: resp.commentCount ?? 0,
          isLiked: resp.isLiked ?? false,
          createdAt: resp.createdAt,
        ));
      }
    }
    return feedsList;
  }
}
