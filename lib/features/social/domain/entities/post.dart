import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'enums/post_type.dart';

class Post {
  String postCode;
  PostType type;
  String image;
  LatLng location;
  String locationName;
  String description;
  String userId;
  int likeCount;
  int commentCount;
  bool isLiked;
  String createdAt;

  Post({
    this.postCode,
    this.type,
    this.image,
    this.location,
    this.locationName,
    this.description,
    this.userId,
    this.likeCount,
    this.commentCount,
    this.isLiked,
    this.createdAt,
  });
}
