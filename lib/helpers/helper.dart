import 'dart:math';
import 'dart:core';

import 'package:military_hub/config/api_config.dart';

class Helper {
  static String limitString(String text,
      {int limit = 24, String hiddenText = "..."}) {
    return text.substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? hiddenText : '');
  }

  static String getImageUrlByIdNumber(int id) {
    return "${API.ImageUrl}/ACM_$id.jpg";
  }
}
