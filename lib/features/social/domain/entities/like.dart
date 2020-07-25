import 'User.dart';
import 'enums/like_type.dart';

class Like {
  String postCode;
  String likeCode;
  String userId;
  LikeType likeType;
  String createdAt;

  Like({
    this.postCode,
    this.likeCode,
    this.userId,
    this.likeType,
    this.createdAt,
  });
}
