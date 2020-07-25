import 'dart:math';
import 'dart:core';

import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  static int getRandomInteger(int max, min) {
    Random rand;
    rand = new Random();
    var result = min + rand.nextInt(max - min);
    return result;
  }

  static LatLng getLatLngFromString(String lat, String lon) {
    double latitude = 0;
    double longitude = 0;
    try {
      latitude = double.parse(lat);
    } on FormatException {
      print('double.parse $lat format error');
    }
    try {
      longitude = double.parse(lon);
    } on FormatException {
      print('double.parse $lon format error');
    }
    return LatLng(latitude, longitude);
  }
}
