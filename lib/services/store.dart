import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:kasrzero_flutter/models/ad.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CategoryApi {
  Future<List<Category>> getcat() async {
    Uri url = Uri.http(KLocalhost, "/product/categories");

    var resp = await http.get(url);
    List<dynamic> data = jsonDecode(resp.body);

    return data
        .map((e) => Category(
              id: e["_id"],
              title: e["title"],
              brands: e["brands"],
              titlefirstFilter: e["firstFilter"]["title"],
              titlesecondFilter: e["secondFilter"]["title"],
              titlethirdFilter: e["thirdFilter"]["title"],
              optionsfirstFilter: e["firstFilter"]["options"],
              optionssecondFilter: e["secondFilter"]["options"],
              optionsthirdFilter: e["thirdFilter"]["options"],
            ))
        .toList();
  }

   getcatbyid(String id) async {
    Uri url = Uri.http(KLocalhost, "/product/categories/$id");
    var resp = await http.get(url);
    var data = jsonDecode(resp.body);
    Category cat = Category(
      id: data["_id"],
      title: data["title"],
      brands: data["brands"],
      titlefirstFilter: data["firstFilter"]["title"],
      titlesecondFilter: data["secondFilter"]["title"],
      titlethirdFilter: data["thirdFilter"]["title"],
      optionsfirstFilter: data["firstFilter"]["options"],
      optionssecondFilter: data["secondFilter"]["options"],
      optionsthirdFilter: data["thirdFilter"]["options"],
    );
    
    return cat;
  }
}

class ProductApi {
  // Future<http.Response>

  PostNewAd(Ad ad, String userId) async {
    Map<String, String> body = {
      'title': ad.title,
      'price': "700",
      'description': ad.description,
      'ableToExchange': ad.ableToExchange,
      'brand': ad.brand,
      'durationOfUse': ad.durationOfUse,
      'color': ad.color,
      'firstFilter': ad.firstFilter,
      'secondFilter': ad.secondFilter,
      'thirdFilter': ad.thirdFilter,
      'categoryId': ad.categoryId
    };
    var uri = Uri.parse("http://$KLocalhost/product/addFromMob/$userId");
    var request = http.MultipartRequest("POST", uri);
    for (int i = 0; i < ad.img.length; i++) {
      var stream =
          http.ByteStream(DelegatingStream.typed(ad.img[i].openRead()));
      var length = await ad.img[0].length();
      print(uri);
      var multipartFile = http.MultipartFile('img', stream, length,
          filename: basename(ad.img[i].path));
      request.files.add(multipartFile);
    }
    request.fields.addAll(body);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<List<Product>> getpro() async {
    Uri url = Uri.http(KLocalhost, "/product/products");
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

  Future<List<Product>> getOffers(String productId) async {
    Uri url = Uri.http(KLocalhost, "/product/offers/$productId");
    var res = await http.get(url);
    var data = jsonDecode(res.body);
    var recievedProducts = data as List;
    List<Product> products = [];
    for (int i = 0; i < recievedProducts.length; i++) {
      Product p = Product(
        id: recievedProducts[i]['_id'],
        ableToExchange: recievedProducts[i]['ableToExchange'],
        brand: recievedProducts[i]['brand'],
        categoryId: recievedProducts[i]['categoryId'],
        color: recievedProducts[i]['color'],
        description: recievedProducts[i]['description'],
        durationOfUse: recievedProducts[i]['durationOfUse'],
        firstFilter: recievedProducts[i]['firstFilter'],
        img: recievedProducts[i]['img'],
        offers: recievedProducts[i]['offers'],
        price: recievedProducts[i]['price'],
        secondFilter: recievedProducts[i]['secondFilter'],
        status: recievedProducts[i]['status'],
        thirdFilter: recievedProducts[i]['thirdFilter'],
        time: recievedProducts[i]['time'],
        title: recievedProducts[i]['title'],
        userId: recievedProducts[i]['userId'],
      );
      products.add(p);
      // print(p.title);
    }
    return products;
    // print(p);
  }
}
