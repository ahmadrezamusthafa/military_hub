import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/domain/entities/action_result.dart';
import 'package:military_hub/features/social/domain/entities/enums/post_type.dart';
import 'package:military_hub/features/social/domain/entities/post.dart';
import 'package:military_hub/features/social/domain/repositories/feeds_repository.dart';

class FeedsUseCase {
  final FeedsRepository repository;

  FeedsUseCase(this.repository);

  Future<List<Post>> getFeeds(
      String email, String password, int page, int limit,
      {OnError errorCallBack}) async {
    return repository.getFeeds(email, password, page, limit,
        errorCallBack: errorCallBack);
  }

  Future<ActionResult> createPost(
      String userId,
      String description,
      String image,
      double latitude,
      double longitude,
      String locationName,
      PostType type,
      {OnError errorCallBack}) async {
    return repository.createPost(
        userId, description, image, latitude, longitude, locationName, type);
  }
}
