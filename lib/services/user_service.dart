import 'dart:convert';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:http/http.dart' as http;

import '../functions.dart';
import '../models/product.dart';

class UserService {
   Future<List<Product>> getuserAds(String id) async {
    Uri url = Uri.http(KLocalhost,"/product/ads/$id");

    var resp = await http.get(url);
    var data = jsonDecode(resp.body);
    var list = data as List;
    return list
        .map((e) => Product(
            id: e["_id"],
            userId: e["userId"],
            categoryId: e["categoryId"],
            title: e["title"],
            price: e["price"],
            description: e["description"],
            brand: e["brand"],
            color: e["color"],
            durationOfUse: e["durationOfUse"],
            img: imageFormat(e["img"]),
            status: e["status"],
            ableToExchange: e["ableToExchange"],
            firstFilter: e["firstFilter"],
            secondFilter: e["secondFilter"],
            thirdFilter: e["thirdFilter"],
            offers: e['offers'],
            time: e['time']))
        .toList();
  }
  Future<UserData>getUser(String email) async {
    Uri url = Uri.http(KLocalhost, "/user/getUser/$email");
    var res = await http.get(url);
    var data = jsonDecode(res.body);
    UserAddress addres = UserAddress();
      addres.blockNumber = data["address"]["blockNumber"];
      addres.area = data["address"]["area"];
      addres.city = data["address"]["city"];
      addres.st = data["address"]["st"];
    return UserData(
        id: data["_id"],
        userName: data["userName"],
        email: data["email"],
        password: data["password"],
        ads: data["ads"],
        cart: data["cart"],
        orders: data["orders"],
        time: data["time"],
        wishlist: data["wishlist"],
        address: addres,
        phoneNumber: data["phoneNumber"]);
  }

  Future<http.Response> updateuserApi(UserData s) async {
    Uri upurl = Uri.http(KLocalhost, "/user/updateUserflutter/${s.id}");
    Map<String, dynamic> body = {
      "userName": s.userName,
      "email": s.email,
      "phoneNumber": s.phoneNumber,
      "area": s.address.area,
      "blockNumber": s.address.blockNumber.toString(),
      "city": s.address.city,
      "st": s.address.st,
    };
    return await http.patch(upurl,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));
  }
  
   Future<http.Response> addcart(String id, String idpro) async {
    Uri cartaddurl = Uri.http(KLocalhost,"/user/addtocart/$id/$idpro");
    return await http.post(cartaddurl, body: {});
  }
  Future<http.Response> removecart(String id, String idpro) async {
    Uri cartaddurl = Uri.http(KLocalhost,"/user/removefromcart/$id/$idpro");
    return await http.post(cartaddurl, body: {});
  }
}
