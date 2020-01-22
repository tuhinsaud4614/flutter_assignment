import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/http_exception.dart';

class Auth with ChangeNotifier {
  bool _isEditMode = false;
  Timer _authTimer;

  Map<String, dynamic> _userInfo = {
    "userId": "",
    "username": "",
    "email": "",
    "token": "",
    "expDate": ""
  };

  Map<String, dynamic> get userInfo {
    return _userInfo;
  }

  bool get isEditMode {
    return _isEditMode;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_userInfo["token"] != "" &&
        _userInfo["expDate"] != null &&
        DateTime(
          int.parse(
            _userInfo["expDate"],
          ),
        ).isAfter(DateTime.now())) {
      return _userInfo["token"];
    }

    return null;
  }

  String get userId {
    return _userInfo["userId"];
  }

  void changeEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  Future<void> signUp(Map<String, String> user) async {
    print(user);
    try {
      var response = await http.post(
        "http://10.0.2.2:80/wordpress_back/wp-json/wp/v2/users/register",
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(user),
      );

      var data = json.decode(response.body);
      if (data["code"] != 200) {
        String errMsg = data["message"];
        throw HttpException(message: errMsg);
      }
      await signIn(
          {"username": user["username"], "password": user["password"]});
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> signIn(Map<String, String> user) async {
    try {
      var response = await http.post(
        "http://10.0.2.2:80/wordpress_back/wp-json/jwt-auth/v1/token",
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(user),
      );
      var data = json.decode(response.body);
      if (data["code"] != null) {
        String errMsg = data["code"].split(" ")[1];
        throw HttpException(message: errMsg);
      }
      var normal = base64Url.normalize(data["token"].split(".")[1]);
      var decoded = json.decode(utf8.decode(base64Url.decode(normal)));
      _userInfo["expDate"] = decoded["exp"].toString();
      _userInfo["token"] = data["token"];
      _userInfo["userId"] = decoded["data"]["user"]["id"];
      _userInfo["username"] = data["user_nicename"];
      _userInfo["email"] = data["user_email"];
      _autoLogout();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userInfo', json.encode(_userInfo));
      notifyListeners();
    } catch (err) {
      print("err: $err");
      throw err;
    }
  }

  Future<void> logOut() async {
    _userInfo = {
      "userId": "",
      "username": "",
      "email": "",
      "token": "",
      "expDate": null
    };
    notifyListeners();
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userInfo');
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userInfo")) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userInfo')) as Map<String, dynamic>;

    final expiryDate = DateTime(int.parse(extractedUserData["expDate"]));
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _userInfo = extractedUserData;
    notifyListeners();
    _autoLogout();
    return true;
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timerToexpiry = DateTime(int.parse(_userInfo["expDate"]))
        .difference(DateTime.now())
        .inSeconds;
    _authTimer = Timer(Duration(seconds: timerToexpiry), logOut);
  }
}
