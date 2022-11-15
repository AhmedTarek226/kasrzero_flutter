// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../Widget/card_widget.dart';
import '../Widget/detailsWidget/custom_app_bar.dart';
import '../constants.dart';
import '../dummy_data.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;

    Future<List<Product>> getData() async {
      Uri url = Uri.http(KLocalhost, "/user/ads/$userId");

      print(url);
      try {
        // await Future.delayed(const Duration(seconds: 10));
        var response = await http.get(url);
        var responseBody = jsonDecode(response.body) as List;
        print("actualProducts[0]");
        List<Product> actualProducts =
            responseBody.map((p) => Product.fromJson(p)).toList();
        // for (var product in actualProducts) {
        //   product.img = imageFormat(product.img);
        // }
        products = actualProducts;
        return actualProducts;
      } catch (e) {
        print(e);
        return [];
      }
    }

    Future<void> removeFromAds(Product item) async {
      Uri url = Uri.http(KLocalhost, "/user/ads/$userId/${item.id}");

      await http.delete(url,
          body: jsonEncode({"title": item}),
          headers: {"Content-Type": "application/json"});
      // add item to the list
      setState(() {});
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(Title: "My Ads"),
        ),
        body: Container(
            // color: Colors.grey[900],
            // width: double.infinity,
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: FutureBuilder(
                initialData: [],
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                      return Center(child: Text('You have no ads. yet'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var item = products[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              height: 300.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 5.w),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Image.network(
                                          fit: BoxFit.contain,
                                          'http://$KLocalhost/${oneImageFormat(item.img[0])}',
                                          width: double.infinity,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.title, style: h4Style),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "Used: ${capitalize(item.durationOfUse)}",
                                            style: h5Style.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            capitalize(item.brand),
                                            style: h5Style.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            capitalize(item.color),
                                            style: h5Style.copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            '${item.price} EGP',
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: KPrimaryColor),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      item.status == "active"
                                                          ? FontAwesomeIcons
                                                              .circleCheck
                                                          : FontAwesomeIcons
                                                              .circleExclamation,
                                                      size: 12.sp,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 3.w,
                                                    ),
                                                    Text(
                                                      item.status,
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              (item.ableToExchange == "true")
                                                  ? item.offers.isEmpty
                                                      ? Flexible(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15.w,
                                                                    vertical:
                                                                        5.h),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black38,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            child: Text(
                                                              "No Offers",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )
                                                      : Flexible(
                                                          child: SizedBox(
                                                          height: 27.h,
                                                          child: ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      KPrimaryColor),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              item.offers.length ==
                                                                      1
                                                                  ? "${item.offers.length} Offer"
                                                                  : "${item.offers.length} Offers",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/exchange_products');
                                                            },
                                                          ),
                                                        ))
                                                  : Container(),
                                              Flexible(
                                                  child: SizedBox(
                                                height: 27.h,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                KPrimaryColor),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () =>
                                                      removeFromAds(item),
                                                ),
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                })));
  }
}
