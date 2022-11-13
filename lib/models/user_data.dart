import 'package:flutter/rendering.dart';

class UserData {
  String id;
  String userName;
  String email;
  String password;
  List wishlist;
  List ads;
  List cart;
  UserAddress address;
  List orders;
  String time;
  String phoneNumber;

  UserData({
    required this.phoneNumber,
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.ads,
    required this.cart,
    required this.orders,
    required this.time,
    required this.wishlist,
    required this.address,
  });
}

class UserAddress {
  int blockNumber = 0;
  String st = "";
  String city = "";
  String area = "";
}

class UpdateUser {
  String userName;
  String email;
  String phoneNumber;
  List<UserAddress> address;
  UpdateUser({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });
}