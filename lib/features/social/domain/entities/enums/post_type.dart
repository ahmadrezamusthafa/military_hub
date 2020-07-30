enum PostType {
  unknown,
  text,
  textWithImage,
  textWithLocation,
}

PostType postTypeFromInt(int type) {
  switch (type) {
    case 1:
      return PostType.text;
    case 2:
      return PostType.textWithImage;
    case 3:
      return PostType.textWithLocation;
  }
  return PostType.unknown;
}

int postTypeToInt(PostType type) {
  switch (type) {
    case PostType.text:
      return 1;
    case PostType.textWithImage:
      return 2;
    case PostType.textWithLocation:
      return 3;
    case PostType.unknown:
      return 0;
  }
  return 0;
}
