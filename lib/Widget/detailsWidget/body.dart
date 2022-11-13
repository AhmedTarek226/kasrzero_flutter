import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kasrzero_flutter/Widget/confirm_exchange_order.dart/new_address_widget.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/services/user_service.dart';
import 'package:provider/provider.dart';

import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

void addcart(
    String id, String idpro, UserProvider userprovider, UserService userserv) {
  print(id);
  var data;
  UserAddress addres = UserAddress();
  userserv.addcart(id, idpro).then((value) => {
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

void removecart(
    String id, String idpro, UserProvider userprovider, UserService userserv) {
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

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    UserData currentUser = userProvider.getUser();
    UserService user = UserService();
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (currentUser.id == "id") {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'You must be login to add in youer cart',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color.fromARGB(134, 255, 172, 64),
                    actions: <Widget>[
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
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed("/signin");
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              if (currentUser.cart.indexOf(widget.product.id) < 0) {
                addcart(currentUser.id, widget.product.id, userProvider, user);
              } else {
                removecart(
                    currentUser.id, widget.product.id, userProvider, user);
              }
            }
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                width: getProportionateScreenWidth(50),
                decoration: BoxDecoration(
                  color: Color.fromARGB(137, 255, 172, 64),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Icon(
                  (currentUser.cart.indexOf(widget.product.id) < 0
                      ? FontAwesomeIcons.cartPlus
                      : FontAwesomeIcons.xmark),
                  size: 20,
                  color: Colors.white,
                )),
          ),
        ),
        ProductImages(product: widget.product),
        Expanded(
          child: TopRoundedContainer(
            color: Colors.white,
            child: ProductDescription(
              product: widget.product,
              pressOnSeeMore: () {},
            ),
          ),
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  (widget.product.ableToExchange == "true"
                      ? Container(
                          width: 0,
                        )
                      : DefaultButton(
                          text: "Buy",
                          press: () {
                            if (currentUser.id == "id") {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'You must be login to add in your cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(134, 255, 172, 64),
                                    actions: <Widget>[
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
                                          'Sign in',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamed("/signin");
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              if (currentUser.address.area == "" ||
                                  currentUser.address.city == "" ||
                                  currentUser.address.st == "") {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return TopRoundedContainer(
                                          color: Colors.white,
                                          child: NewAddressModal());
                                    });
                              } else {
                                Navigator.of(context).pushNamed(
                                    "/confirm_order",
                                    arguments: widget.product);
                              }
                            }
                          },
                        )),
                  (widget.product.ableToExchange == "true"
                      ? Row(
                          children: [
                            DefaultButton(
                              text: "Buy",
                              press: () {
                                if (currentUser.id == "id") {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'You must be login to buy',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(134, 255, 172, 64),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              'Sign in',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pushNamed("/signin");
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  if (currentUser.address.area == "" ||
                                      currentUser.address.city == "" ||
                                      currentUser.address.st == "") {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return TopRoundedContainer(
                                              color: Colors.white,
                                              child: NewAddressModal());
                                        });
                                  } else {
                                    Navigator.of(context).pushNamed(
                                        "/confirm_order",
                                        arguments: widget.product);
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            DefaultButton(
                              text: "Exhange",
                              press: () {
                                if (currentUser.id == "id") {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'You must be login to Exchange items',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(134, 255, 172, 64),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              'Sign in',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pushNamed("/signin");
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  if (currentUser.address.area == "" ||
                                      currentUser.address.city == "" ||
                                      currentUser.address.st == "") {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return TopRoundedContainer(
                                              color: Colors.white,
                                              child: NewAddressModal());
                                        });
                                  } else {
                                    if (currentUser.ads.length == 0) {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'You must be have ads to Exchange',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Color.fromARGB(
                                                134, 255, 172, 64),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushNamed("/post_ad");
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {}
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      : Container()),
                ],
              )),
        ),
      ],
    );
  }
}
