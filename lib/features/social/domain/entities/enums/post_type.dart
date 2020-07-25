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
