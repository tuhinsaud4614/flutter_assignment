// import 'package:flutter/foundation.dart';

class User {
  String firstName;
  String lastName;
  String username;
  String email;
  String password;

  User({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
  });

  User.signUpFromJson(Map<String, String> json)
      : firstName = "",
        lastName = "",
        email = json["email"],
        username = json['username'],
        password = json['password'];

  User.signInFromJson(Map<String, String> json)
      : firstName = "",
        lastName = "",
        username = json['username'],
        password = json['password'];

  Map<String, String> toSignUpJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
    };
  }

  Map<String, String> toSignInJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}
