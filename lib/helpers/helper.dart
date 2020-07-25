import 'dart:io';
import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    } catch (e) {
      print('double.parse $lat format error: ${e.toString()}');
    }
    try {
      longitude = double.parse(lon);
    } catch (e) {
      print('double.parse $lon format error: ${e.toString()}');
    }
    return LatLng(latitude, longitude);
  }

  static String getReadableCreatedAt(String dateAt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime createdAt = DateTime.parse(dateAt);
    DateTime createdDate =
        DateTime(createdAt.year, createdAt.month, createdAt.day);
    if (createdDate.compareTo(today) == 0) {
      var formatter = new DateFormat('kk:mm');
      return formatter.format(createdAt);
    } else if (createdDate.compareTo(yesterday) == 0) {
      return "Yesterday";
    } else {
      var formatter = new DateFormat('MM/dd');
      return formatter.format(createdAt);
    }
  }

  static FileImage loadImageFromFile(String path) {
    File file = new File(path);
    FileImage img = FileImage(file);
    return img;
  }
}
