import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

bool isUrl(String value) {
  RegExp url = new RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
  return url.hasMatch(value);
}

bool strNotEmpty(String value) {
  if (value == null) return false;
  return value.trim().isNotEmpty;
}

bool mapNotEmpty(Map value) {
  if (value == null) return false;
  return value.isNotEmpty;
}

bool listNotEmpty(List list) {
  if (list == null) return false;
  if (list.length == 0) return false;
  return true;
}

bool isNetWorkImg(String img) {
  return img.startsWith('http') || img.startsWith('https');
}

bool isAssetsImg(String img) {
  return img.startsWith('asset') || img.startsWith('assets');
}

bool isTargetAndroid() {
  return debugDefaultTargetPlatformOverride == TargetPlatform.android;
}

bool isTargetIOS() {
  return debugDefaultTargetPlatformOverride == TargetPlatform.iOS;
}

bool isTargetWindows() {
  return debugDefaultTargetPlatformOverride == TargetPlatform.windows;
}
