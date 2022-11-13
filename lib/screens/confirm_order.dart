import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/screens/exchange_products_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/screens/add_credit_screen.dart';

import '../Widget/confirm_exchange_order.dart/new_address_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          leadingWidth: 30.w,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Confirm order",
            style: TextStyle(fontSize: 18.sp),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                // todo //confirm offer
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Text(args.currentProduct.title.toString()),
              // Text(args.selectedProduct.title.toString())
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentMethod = "cod";
                        });
                      },
                      child: Container(
                        height: 50.h,
                        color: paymentMethod == "cod"
                            ? KPrimaryColor
                            : Colors.white,
                        child: Center(
                            child: Text(
                          "COD",
                          style: TextStyle(
                              color: paymentMethod == "cod"
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentMethod = "credit";
                        });
                      },
                      child: Container(
                        height: 50.h,
                        color: paymentMethod == "credit"
                            ? KPrimaryColor
                            : Colors.white,
                        child: Center(
                            child: Text(
                          "Credit",
                          style: TextStyle(
                              color: paymentMethod == "credit"
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              // Divider(color: KPrimaryColor, height: 1),
              paymentMethod == "credit"
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Choose an credit card",
                                style: TextStyle(
                                    // color: KPrimaryColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/add_credit_card');
                                  },
                                  icon: Icon(
                                    Icons.add_card_outlined,
                                    size: 22,
                                    color: KPrimaryColor,
                                  ))
                            ],
                          ),
                          Container(
                            height: 150.h,
                            width: double.infinity,
                            // color: Colors.grey[200],
                            child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: RadioListTile(
                                    activeColor: KPrimaryColor,
                                    // selected: true,
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                      "234032948098234",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black87),
                                    ),
                                    value: "234032948098234",
                                    groupValue: selectedCredit,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCredit = value.toString();
                                        print(value);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Choose an address",
                      style: TextStyle(
                          // color: KPrimaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return NewAddressModal();
                            },
                          );
                        },
                        icon: Icon(
                          Icons.add_location_alt_outlined,
                          size: 22,
                          color: KPrimaryColor,
                        ))
                  ],
                ),
              ),

              Container(
                height: 149.3.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),

                // color: Colors.grey[200],
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      child: RadioListTile(
                        activeColor: KPrimaryColor,
                        // selected: true,
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          "11 manshyt esmat ain shams - door tamn",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.black87),
                        ),
                        value: "11 manshyt esmat ain shams - door tamn",
                        groupValue: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value.toString();
                            print(value);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              paymentMethod == "cod"
                  ? SizedBox(
                      height: 221.h,
                    )
                  : Container(),
              Container(
                height: 131.h,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Product price: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Difference: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Shipping: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Taxes: ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '14000 EGP',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '2000 EGP',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '50 EGP',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '100 EGP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      // SizedBox(width: 10.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total cost',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            '1300 EGP',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  KPrimaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text("Finish"),
                            ),
                          )
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
  }
}
