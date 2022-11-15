// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';

import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/detailsWidget/custom_app_bar.dart';
import '../constants.dart';
import '../dummy_data.dart';
import '../models/product.dart';

class MyWishlistScreen extends StatefulWidget {
  const MyWishlistScreen({super.key});

  @override
  State<MyWishlistScreen> createState() => _MyWishlistScreenState();
}

class _MyWishlistScreenState extends State<MyWishlistScreen> {
  TextEditingController wish = new TextEditingController();
  OutlineInputBorder styleBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: const BorderSide(color: KPrimaryColor),
  );
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.getUser();
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;

    Future<List<String>> getData() async {
      Uri url = Uri.http(KLocalhost, "/user/wishlist/$userId");

      print(url);
      try {
        var response = await http.get(url);
        List<String> wishlistFromJson(String str) =>
            List<String>.from(json.decode(str).map((x) => x));

        print(userId);
        var x = wishlistFromJson(response.body);
        print(x);
        return x;
      } catch (e) {
        print(e);
        return [];
      }
    }

    Future addToWishlist() async {
      Uri url = Uri.http(KLocalhost, "/user/wishlist/$userId");
      try {
        print(url);
        // make post req to backend, with the item to be added
        await http.post(url,
            body: jsonEncode({"title": wish.text}),
            headers: {"Content-Type": "application/json"});
        // add item to the list
        setState(() {});
        // clear user input
        wish.clear();
      } catch (e) {
        // in case of error, send a message with the error

      }
    }

    Future<void> removeItemFromWishList(String item) async {
      Uri url = Uri.http(KLocalhost, "/user/wishlist/$userId");

      await http.delete(url,
          body: jsonEncode({"title": item}),
          headers: {"Content-Type": "application/json"});
      // add item to the list
      setState(() {});
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
          Title: "My Wishlist",
          lead: false,
        ),
      ),
      body: currentUser.id != "id"
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                children: [
                  TextFormField(
                    controller: wish,
                    cursorColor: KPrimaryColor,
                    decoration: InputDecoration(
                      label: Text(
                        "Item Name",
                        style: TextStyle(color: KPrimaryColor, fontSize: 15.sp),
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.heart,
                        size: 20,
                        color: KPrimaryColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                      focusedBorder: styleBorder,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      errorBorder: styleBorder,
                      focusedErrorBorder: styleBorder,
                      errorStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultButton(text: "Add", press: () => addToWishlist()),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        initialData: [],
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: KPrimaryColor,
                                size: 30,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('Your wishlist is empty!'));
                            }
                            return RefreshIndicator(
                              onRefresh: () async {
                                await getData();
                                setState(() {});
                              },
                              child: ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  var item = snapshot.data![index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 8.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "$item",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.black26),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                "Remove",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                removeItemFromWishList(item);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You should login to show this page !"),
                  SizedBox(
                    height: 20.h,
                  ),
                  DefaultButton(
                    press: () => Navigator.pushNamed(context, "/signin"),
                    text: "Login !",
                  )
                ],
              ),
            )
    );
  }
}
