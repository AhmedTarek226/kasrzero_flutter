import 'package:flutter/cupertino.dart';
import 'package:kasrzero_flutter/models/user_data.dart';

UserData noUser = UserData(
    id: "id",
    userName: "userName",
    email: "email",
    password: "password",
    ads: [],
    cart: [],
    orders: [],
    time: "time",
    wishlist: [],
    address: UserAddress(),
    phoneNumber: "");

class UserProvider with ChangeNotifier {
  UserData user = noUser;
  setUser(UserData userData) {
    user = userData;
    notifyListeners();
  }

  UserData getUser() {
    return user;
  }

  logoutUser() {
    user = noUser;
    notifyListeners();
  }
}
