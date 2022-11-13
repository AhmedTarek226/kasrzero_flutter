import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/services/user_service.dart';
import 'package:provider/provider.dart';

class NewAddressModal extends StatefulWidget {
  NewAddressModal({super.key});

  @override
  State<NewAddressModal> createState() => _NewAddressModalState();
}

class _NewAddressModalState extends State<NewAddressModal> {
  UserAddress address = UserAddress();

  final _addressFormKey = GlobalKey<FormState>();
  var up = UserService();
  UserData update = UserData(
      phoneNumber: "",
      id: "",
      userName: "",
      email: "",
      password: "",
      ads: [],
      cart: [],
      orders: [],
      time: "",
      wishlist: [],
      address: UserAddress());
  UserAddress addres = UserAddress();
  String x = "";
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.getUser();

    return Container(
      height: 400,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _addressFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  cursorColor: KPrimaryColor,
                  decoration: InputDecoration(
                    label: const Text("Block number",
                        style: TextStyle(color: KPrimaryColor)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: KPrimaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      x = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                TextFormField(
                  cursorColor: KPrimaryColor,
                  decoration: InputDecoration(
                    label: const Text("Street name",
                        style: TextStyle(color: KPrimaryColor)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: KPrimaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      address.st = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                TextFormField(
                  cursorColor: KPrimaryColor,
                  decoration: InputDecoration(
                    label: const Text("Area",
                        style: TextStyle(color: KPrimaryColor)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: KPrimaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      address.area = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                TextFormField(
                  cursorColor: KPrimaryColor,
                  decoration: InputDecoration(
                    label: const Text("City",
                        style: TextStyle(color: KPrimaryColor)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: KPrimaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      address.city = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                ElevatedButton(
                    child: const Text(
                      'Add address',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(KPrimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_addressFormKey.currentState!.validate()) {
                        _addressFormKey.currentState!.save();
                        print(int.parse(x));
                        setState(() {
                          addres.area = address.area;
                          addres.city = address.city;
                          addres.st = address.st;
                          addres.blockNumber = int.parse(x);
                          update.id = currentUser.id;
                          update.userName = currentUser.userName;
                          update.email = currentUser.email;
                          update.phoneNumber = currentUser.phoneNumber;
                          update.address = addres;
                          update.ads = currentUser.ads;
                          update.orders = currentUser.orders;
                          update.cart = currentUser.cart;
                          update.id = currentUser.id;
                          update.wishlist = currentUser.wishlist;
                          update.time = currentUser.time;
                          update.password = currentUser.password;
                          up.updateuserApi(update).then((value) async {
                            // print(value.body);
                          });
                          userProvider.setUser(update);
                        });
                        print(
                            "${address.blockNumber} ${address.st}, ${address.area}, ${address.city}");
                        Navigator.of(context).pop();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
