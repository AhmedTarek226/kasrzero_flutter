import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasrzero_flutter/Widget/card_widget.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:kasrzero_flutter/services/user_service.dart';

class listofads extends StatefulWidget {
  String id;
  List<Product> ads = [];
  Product sellerProduct;
  listofads({
    required this.sellerProduct,
    required this.id,
  });
  @override
  State<listofads> createState() => _listofadsState();
}

class _listofadsState extends State<listofads> {
  UserService userserve = UserService();
  Product pro = Product(
      id: "id",
      userId: "userId",
      categoryId: "categoryId",
      title: "title",
      price: 0,
      description: "description",
      brand: "brand",
      color: "color",
      durationOfUse: "durationOfUse",
      img: [],
      status: "status",
      ableToExchange: "ableToExchange",
      firstFilter: "firstFilter",
      secondFilter: "secondFilter",
      thirdFilter: "thirdFilter",
      time: "time",
      offers: []);
  void initState() {
    userserve.getuserAds(widget.id).then(((value) {
      setState(() {
        widget.ads =
            value.where((element) => element.status == "active").toList();
      });
    }));
  }

  String isslect = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: 400,
            child: FurnitureListView(
              isslected: isslect,
              ProductList: widget.ads,
              isHorizontal: false,
              onTap: (product) {
                // print("jghgj");
                setState(() {
                  pro = product;
                  isslect = product.id;
                });
              },
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: DefaultButton(
            color: isslect != "" ? KPrimaryColor : Colors.black54,
            text: "Send offer",
            press: () {
              if (isslect != "") {
                Navigator.of(context).pushNamed("/confirm_order",
                    arguments: [widget.sellerProduct, pro, true]);
              }
            },
          ),
        )
      ],
    );
  }
}
