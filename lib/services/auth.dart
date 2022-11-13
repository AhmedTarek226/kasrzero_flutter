import 'dart:convert';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/user_login.dart';
import 'package:http/http.dart' as http;
import 'package:kasrzero_flutter/models/user_signup.dart';

class Auth {
  Future<http.Response> Login(UserLogin user) async {
    Uri loginUrl = Uri.http(KLocalhost, "/user/login");   
    Map<String, String> body = {
      'email': user.email,
      'password': user.password
    };
    return await http.post(loginUrl,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));
   
  }

  Future<http.Response> Signup(UserSignup user) async {
    Uri signupUrl = Uri.http(KLocalhost, "/user/register");   
    Map<String, String> body = {
      'email': user.email,
      'password': user.password,
      'userName': user.userName,
      'phoneNumber': user.phoneNumber,
    };
    return await http.post(signupUrl,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));
  }
  
}
