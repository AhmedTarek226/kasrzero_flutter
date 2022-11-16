// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../Widget/card_widget.dart';
import '../Widget/confirm_exchange_order.dart/new_address_widget.dart';
import '../Widget/confirm_exchange_order.dart/select_ads_to_exchange.dart';
import '../Widget/detailsWidget/top_rounded_container.dart';
import '../constants.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.getUser();
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;

    Future<List<Product>> getData() async {
      Uri url = Uri.http(KLocalhost, "/user/cartitems/$userId");

      print(url);
      try {
        var response = await http.get(url);
        print(response.body);
        List<Product> responseBody = List<Product>.from(
            json.decode(response.body).map((x) => Product.fromJson(x)));
        return responseBody;
      } catch (e) {
        print(e);
        return [];
      }
    }

    Future<void> removeItemFromCart(String productId) async {
      Uri url = Uri.http(KLocalhost, "/user/removefromcart/$userId/$productId");

      await http.post(url);
      // add item to the list
      setState(() {});
    }

    void removecart(String id, String idpro, UserProvider userprovider,
        UserService userserv) {
      print(id);
      var data;
      UserAddress addres = UserAddress();
      userserv.removecart(id, idpro).then((value) => {
            // print(value.body),
            data = json.decode(value.body),
            addres.blockNumber = data["address"]["blockNumber"],
            addres.area = data["address"]["area"],
            addres.city = data["address"]["city"],
            addres.st = data["address"]["st"],
            userprovider.setUser(UserData(
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
                phoneNumber: data["phoneNumber"]))
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
          Title: "My Cart",
          lead: false,
        ),
      ),
      body: currentUser.id != "id"
          ? Container(
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
                    return Center(child: Text('Your Cart is empty!!'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        Product item = snapshot.data![index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              height: 310.h,
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
                                          horizontal: 15.w, vertical: 10.h),
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
                                            height: 15.h,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children:
                                                  item.ableToExchange == "true"
                                                      ? [
                                                          Flexible(
                                                            child: CardButton(
                                                              text: "Buy",
                                                              pressed: () {
                                                                if (currentUser.address.area == "" ||
                                                                    currentUser
                                                                            .address
                                                                            .city ==
                                                                        "" ||
                                                                    currentUser
                                                                            .address
                                                                            .st ==
                                                                        "") {
                                                                  showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return TopRoundedContainer(
                                                                            color:
                                                                                Colors.white,
                                                                            child: NewAddressModal());
                                                                      });
                                                                } else {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushNamed(
                                                                          "/confirm_order",
                                                                          arguments: [
                                                                        item
                                                                      ]);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: CardButton(
                                                              text: "Exchange",
                                                              pressed: () {
                                                                if (currentUser.address.area == "" ||
                                                                    currentUser
                                                                            .address
                                                                            .city ==
                                                                        "" ||
                                                                    currentUser
                                                                            .address
                                                                            .st ==
                                                                        "") {
                                                                  showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return TopRoundedContainer(
                                                                            color:
                                                                                Colors.white,
                                                                            child: NewAddressModal());
                                                                      });
                                                                } else {
                                                                  if (currentUser
                                                                          .ads
                                                                          .length ==
                                                                      0) {
                                                                    showDialog<
                                                                        void>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false, // user must tap button!
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            'You must be have ads to Exchange',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                          backgroundColor: Color.fromARGB(
                                                                              134,
                                                                              255,
                                                                              172,
                                                                              64),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              child: const Text(
                                                                                'Cancel',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                            SizedBox(
                                                                              width: 100,
                                                                            ),
                                                                            TextButton(
                                                                              child: const Text(
                                                                                'add ads',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                                Navigator.of(context).pushNamed("/post_ad");
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  } else {
                                                                    // print("ghghg");
                                                                    showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return TopRoundedContainer(
                                                                              color: Colors.white,
                                                                              child: listofads(
                                                                                sellerProduct: item,
                                                                                id: currentUser.id,
                                                                              ));
                                                                        });
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: CardButton(
                                                              text: "Remove",
                                                              color: Colors
                                                                  .black87,
                                                              pressed: () => {
                                                                removeItemFromCart(
                                                                    item.id)
                                                              },
                                                            ),
                                                          ),
                                                        ]
                                                      : [
                                                          Flexible(
                                                              child: SizedBox(
                                                            height: 27.h,
                                                            child:
                                                                ElevatedButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<Color>(
                                                                              KPrimaryColor),
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      "Buy",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    onPressed:
                                                                        () {}),
                                                          )),
                                                        ])
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ))
          : Center(
              child: ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
            )),
    );
  }
}

class CardButton extends StatelessWidget {
  CardButton(
      {super.key,
      this.color = KPrimaryColor,
      required this.text,
      required this.pressed});
  final color;
  final text;
  Function pressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: pressed as void Function()?,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
