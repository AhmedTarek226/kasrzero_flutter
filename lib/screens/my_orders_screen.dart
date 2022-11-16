// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/Widget/order_widgets/show_buying.dart';
import 'package:kasrzero_flutter/Widget/order_widgets/show_exchange.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:kasrzero_flutter/services/store.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../Widget/card_widget.dart';
import '../Widget/detailsWidget/custom_app_bar.dart';
import '../constants.dart';
import '../dummy_data.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  List orders = [];

  @override
  Widget build(BuildContext context) {
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;

    Future<List> getData() async {
      Uri url = Uri.http(KLocalhost, "/order/mobileGetOrders/$userId");

      print(url);
      try {
        var response = await http.get(url);
        var responseBody = jsonDecode(response.body) as List;
        List actualOrders = responseBody as List;
        // print(actualOrders[0]['product']);
        orders = actualOrders;
        return actualOrders;
      } catch (e) {
        print(e);
        return [];
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(Title: "My Orders"),
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
                return Center(child: Text('You have no orders. yet'));
              }
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var item = orders[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Card(
                      color: Colors.white,
                      child: Container(
                          height: 200.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(5)),
                          child: orders[index]['product'] != null
                              ? ShowBuyingOrder(
                                  order: orders[index],
                                )
                              : ShowExchangeOrder(
                                  order: orders[index],
                                )),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
