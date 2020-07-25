import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/domain/entities/post.dart';

abstract class FeedsRepository {
  Future<List<Post>> getFeeds(
      String email, String password, int page, int limit,
      {OnError errorCallBack});
}
