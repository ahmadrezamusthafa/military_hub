import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/data/datasources/msengine/msengine_feeds_repository.dart';
import 'package:military_hub/features/social/data/models/msengine/api/params/create_post_model.dart';
import 'package:military_hub/features/social/domain/entities/action_result.dart';
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
    var responses = await msEngineFeedsRepository
        .getFeeds(email, password, page, limit, errorCallBack: errorCallBack);
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
          name: resp.name ?? "",
          profilePicture: resp.profilePicture ?? "",
          likeCount: resp.likeCount ?? 0,
          commentCount: resp.commentCount ?? 0,
          isLiked: resp.isLiked ?? false,
          createdAt: resp.createdAt,
          userLocation:
              Helper.getLatLngFromString(resp.userLatitude, resp.userLongitude),
          readableCreatedAt: Helper.getReadableCreatedAt(resp.createdAt),
        ));
      }
    }
    feedsList.sort((a, b) => Comparable.compare(b.createdAt, a.createdAt));
    return feedsList;
  }

  @override
  Future<ActionResult> createPost(
      String userId,
      String description,
      String image,
      double latitude,
      double longitude,
      String locationName,
      PostType type,
      {errorCallBack}) async {
    ActionResult result;
    CreatePostModel param = new CreatePostModel(
      userId: userId,
      description: description,
      image: image,
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      locationName: locationName,
      type: postTypeToInt(type),
    );
    var response = await msEngineFeedsRepository.createPost(param);
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
}
