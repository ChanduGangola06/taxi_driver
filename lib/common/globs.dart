import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:taxi_driver/main.dart';

class Globs {
  static const appname = "Taxi Driver";

  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  static void showHUD({String status = "loading ...."}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs?.setString(key, jsonStr);
  }

  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  static void udBoolSet(bool data, String key) {
    prefs?.setBool(key, data);
  }

  static void udIntSet(int data, String key) {
    prefs?.setInt(key, data);
  }

  static void udDoubleSet(double data, String key) {
    prefs?.setDouble(key, data);
  }

  static dynamic udValue(String key) {
    return json.decode(prefs?.get(key) as String? ?? "{}");
  }

  static dynamic udValueString(String key) {
    return prefs?.getString(key) ?? "";
  }

  static dynamic udValueBool(String key) {
    return prefs?.getBool(key) ?? false;
  }

  static dynamic udValueTrueBool(String key) {
    return prefs?.getBool(key) ?? true;
  }

  static dynamic udValueInt(String key) {
    return prefs?.getInt(key) ?? 0;
  }

  static dynamic udValueDouble(String key) {
    return prefs?.getDouble(key) ?? 0.0;
  }

  static void udRemove(String key) {
    prefs?.remove(key);
  }

  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      return "";
    }
  }
}

class SVKey {
  static const mainUrl = "http://localhost:301";
  static const baseUrl = '$mainUrl/api/';
  static const nodeurl = mainUrl;

  static const svLogin = "${baseUrl}login";
  static const svProfileImageUpload = "${baseUrl}profile_image";
  static const svServiceAndZoneList = "${baseUrl}service_and_zone_list";
  static const svProfileUpdate = "${baseUrl}profile_update";
}

class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";

  static const authToken = "auth_token";
}

class MSG {
  static const success = "success";
  static const fail = "fail";
}
