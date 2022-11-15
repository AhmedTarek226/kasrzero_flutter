import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/top_rounded_container.dart';
import 'package:kasrzero_flutter/Widget/paypal_widget.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:kasrzero_flutter/models/order.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/screens/exchange_products_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/screens/add_credit_screen.dart';
import 'package:kasrzero_flutter/services/store.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Widget/confirm_exchange_order.dart/new_address_widget.dart';
import '../Widget/detailsWidget/custom_app_bar.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  String paymentMethod = "cod";
  String selectedCredit = "";
  String selectedAddress = "";
  final _addressFormKey = GlobalKey<FormState>();
  final _creditCardFormKey = GlobalKey<FormState>();
  final address = {"blockNumber": 0, "st": "", "area": "", "city": ""};

  var titlesStyle = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white);
  var priceStyle = TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white);

  bool isLoading = false;
  final _orderApi = OrderApi();
  _createBuyingOrder(BuyingOrder order) async {
    // setState(() {
    //   isLoading = true;
    // });
    var res = await _orderApi.createBuyingOrder(order);
    print(res.body);
    // Navigator.pushReplacementNamed(context, '/finish_order');

    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _products =
        ModalRoute.of(context)?.settings.arguments as List<Product>;
    final currentUser = Provider.of<UserProvider>(context).getUser();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(
              Title: _products.length > 1 ? "Confirm Offer" : "Confirm Order"),
        ),
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: KPrimaryColor,
                  size: 30,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        _products[0].title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 19.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: _products.length > 1
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Product price: ',
                                            style: titlesStyle),
                                        Text('Your product price: ',
                                            style: titlesStyle),
                                        Text(
                                          'Difference: ',
                                          style: titlesStyle,
                                        ),
                                        Text(
                                          'Shipping: ',
                                          style: titlesStyle,
                                        ),
                                        Text(
                                          'Taxes: ',
                                          style: titlesStyle,
                                        ),
                                        Text(
                                          'TOTAL COST ',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${_products[0].price} EGP",
                                            style: priceStyle),
                                        Text("${_products[1].price} EGP",
                                            style: priceStyle),
                                        Text(
                                            "${_products[1].price - _products[0].price} EGP",
                                            style: priceStyle),
                                        Text("$shipping EGP",
                                            style: priceStyle),
                                        Text(
                                            "${getTaxes(_products[0].price)} EGP",
                                            style: priceStyle),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w, vertical: 7.h),
                                          decoration: const BoxDecoration(
                                            color: KPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            "${getTotalOfferCost(_products[0].price, _products[1].price)} EGP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(width: 10.w,),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Product price: ',
                                            style: titlesStyle),
                                        Text(
                                          'Shipping: ',
                                          style: titlesStyle,
                                        ),
                                        Text(
                                          'Taxes: ',
                                          style: titlesStyle,
                                        ),
                                        Text(
                                          'TOTAL COST ',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${_products[0].price} EGP",
                                            style: priceStyle),
                                        Text("$shipping EGP",
                                            style: priceStyle),
                                        Text(
                                            "${getTaxes(_products[0].price)} EGP",
                                            style: priceStyle),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w, vertical: 7.h),
                                          decoration: const BoxDecoration(
                                            color: KPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            "${getTotal(_products[0].price)} EGP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(width: 10.w,),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultButton(
                                text: "Buy COD",
                                press: () async {
                                  if (_products.length > 1) {
                                    // create offer
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final _productsApi = ProductApi();
                                    var res = await _productsApi.sendOffer(
                                        _products[0].id, _products[1].id);
                                    if (res.body != "failed") {
                                      Navigator.pushReplacementNamed(
                                          context, '/finish_offer');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "The offer failed to send !")));
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    BuyingOrder _newBuyingOrder = BuyingOrder(
                                        addressto: currentUser.address,
                                        buyerId: currentUser.id,
                                        productId: _products[0].id,
                                        productPrice: _products[0].price,
                                        profit: getTaxes(_products[0].price),
                                        sellerId: _products[0].userId,
                                        shipping: shipping,
                                        paymentmethod: "cod");
                                    _createBuyingOrder(_newBuyingOrder);
                                  }
                                },
                              ),
                              DefaultButton(
                                text: "Buy Credit",
                                press: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              paypalWIdget(totalprise: 100)));
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
