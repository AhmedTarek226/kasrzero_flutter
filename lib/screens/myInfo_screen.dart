// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/services/user_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

var up = UserService();
bool isupdate = true;
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
String inusername = "";
String inemail = "";
String inphone = "";
String incity = "";
String inarea = "";
String inblocknmber = "";
String inst = "";

class _MyInfoScreenState extends State<MyInfoScreen> {
  void getinusername(String value) {
    setState(() {
      inusername = value;
    });
  }

  void getinemail(String value) {
    setState(() {
      inemail = value;
    });
  }

  void getinphone(String value) {
    setState(() {
      inphone = value;
    });
  }

  void getincity(String value) {
    setState(() {
      incity = value;
    });
  }

  void getinarea(String value) {
    setState(() {
      inarea = value;
    });
  }

  void getinblocknmber(String value) {
    setState(() {
      inblocknmber = value;
    });
  }

  void getinst(String value) {
    setState(() {
      inst = value;
    });
  }

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.getUser();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(Title: "My Information"),
      ),
      body: isLoading == true
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: KPrimaryColor,
                size: 30,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    buildTextField(
                      labelText: "Full Name",
                      placehoder: currentUser.userName,
                      icon: Icons.abc,
                      isupdate: isupdate,
                      valuedata: inusername,
                      getdata: getinusername,
                    ),
                    buildTextField(
                      labelText: "E-mail",
                      placehoder: currentUser.email,
                      icon: Icons.email_outlined,
                      isupdate: isupdate,
                      valuedata: inemail,
                      getdata: getinemail,
                    ),
                    buildTextField(
                      labelText: "Phone Number",
                      placehoder: currentUser.phoneNumber,
                      icon: Icons.phone_outlined,
                      isupdate: isupdate,
                      valuedata: inphone,
                      getdata: getinphone,
                    ),
                    buildTextField(
                      labelText: "Block Number",
                      placehoder: (currentUser.address.blockNumber == 0
                          ? ""
                          : currentUser.address.blockNumber.toString()),
                      icon: Icons.location_on_outlined,
                      isupdate: isupdate,
                      valuedata: inblocknmber,
                      getdata: getinblocknmber,
                    ),
                    buildTextField(
                      labelText: "Street",
                      placehoder: (currentUser.address.st == ""
                          ? ""
                          : currentUser.address.st),
                      icon: Icons.location_on_outlined,
                      isupdate: isupdate,
                      valuedata: inst,
                      getdata: getinst,
                    ),
                    buildTextField(
                      labelText: "Area",
                      placehoder: (currentUser.address.area == ""
                          ? ""
                          : currentUser.address.area),
                      icon: Icons.location_on_outlined,
                      isupdate: isupdate,
                      valuedata: inarea,
                      getdata: getinarea,
                    ),
                    buildTextField(
                      labelText: "City",
                      placehoder: (currentUser.address.city == ""
                          ? ""
                          : currentUser.address.city),
                      icon: Icons.location_on_outlined,
                      isupdate: isupdate,
                      valuedata: incity,
                      getdata: getincity,
                    ),
                    (isupdate == true
                        ? DefaultButton(
                            text: "Edit",
                            press: () {
                              setState(() {
                                isupdate = false;
                              });
                            },
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DefaultButton(
                                text: "Cancel",
                                press: () {
                                  setState(() {
                                    isupdate = true;
                                  });
                                },
                              ),
                              DefaultButton(
                                text: "Save",
                                press: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isupdate = true;
                                      addres.area = (inarea == ""
                                          ? currentUser.address.area
                                          : inarea);
                                      addres.city = (incity == ""
                                          ? currentUser.address.city
                                          : incity);
                                      addres.st = (inst == ""
                                          ? currentUser.address.st
                                          : inst);
                                      addres.blockNumber = (inblocknmber == ""
                                          ? currentUser.address.blockNumber
                                          : int.parse(inblocknmber));
                                      update.id = currentUser.id;
                                      update.userName = (inusername == ""
                                          ? currentUser.userName
                                          : inusername);
                                      update.email = (inemail == ""
                                          ? currentUser.email
                                          : inemail);
                                      update.phoneNumber = (inphone == ""
                                          ? currentUser.phoneNumber
                                          : inphone);
                                      update.address = addres;
                                      update.ads = currentUser.ads;
                                      update.orders = currentUser.orders;
                                      update.cart = currentUser.cart;
                                      update.id = currentUser.id;
                                      update.wishlist = currentUser.wishlist;
                                      update.time = currentUser.time;
                                      update.password = currentUser.password;
                                    });
                                    up.updateuserApi(update).then((value) {
                                      // print(value.body);
                                      if (value.body == "success") {
                                        userProvider.setUser(update);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Updated successfully")));
                                      } else {
                                        // setState(() {
                                        //   // currentUser = currentUser;
                                        //   // inemail = currentUser.email;
                                        //   // update.email = currentUser.email;
                                        //   // inusername = currentUser.userName;
                                        //   // update.userName =
                                        //   //     currentUser.userName;
                                        //   // inphone = currentUser.phoneNumber;
                                        //   // update.phoneNumber =
                                        //   //     currentUser.phoneNumber;
                                        //   // inarea = currentUser.address.area;
                                        //   // update.address.area =
                                        //   //     currentUser.address.area;
                                        //   // inblocknmber = currentUser
                                        //   //     .address.blockNumber
                                        //   //     .toString();
                                        //   // update.address.blockNumber =
                                        //   //     currentUser.address.blockNumber;
                                        //   // incity = currentUser.address.city;
                                        //   // update.address.city =
                                        //   //     currentUser.address.city;
                                        //   // inst = currentUser.address.st;
                                        //   // update.address.city =
                                        //   //     currentUser.address.st;
                                        // });

                                        if (value.body == "failed" ||
                                            value.body == "invalid user") {
                                          // userProvider.setUser(currentUser);
                                          print(userProvider.getUser().email);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Failed to update !!")));
                                        } else if (value.body ==
                                            "already exist") {
                                          // userProvider.setUser(currentUser);
                                          print(userProvider.getUser().email);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "User already exists !!")));
                                        }
                                      }
                                    }).catchError((err) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Connection failed !!")));
                                    });
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                              )
                            ],
                          ))
                  ],
                ),
              ),
            ),
    );
  }
}

class buildTextField extends StatefulWidget {
  String labelText;
  String placehoder;
  IconData icon;
  bool isupdate;
  String valuedata;
  void Function(String) getdata;
  buildTextField({
    required this.labelText,
    required this.placehoder,
    required this.icon,
    required this.isupdate,
    required this.valuedata,
    required this.getdata,
  });

  @override
  State<buildTextField> createState() => _buildTextFieldState();
}

class _buildTextFieldState extends State<buildTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          onChanged: (value) {
            widget.getdata(value);
          },
          readOnly: widget.isupdate,
          cursorColor: KPrimaryColor,
          initialValue: widget.placehoder,
          inputFormatters: widget.labelText == "Phone Number" ||
                  widget.labelText == "Block Number"
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field shouldn't be empty !";
            }
            if (widget.labelText == "Phone Number" &&
                (value.length != 11 || !value.startsWith('01'))) {
              return "Phone number should be 11 numbers starts with '01' !!";
            }
            return null;
          },
          decoration: InputDecoration(
            label: Text(
              widget.labelText,
              style: TextStyle(color: KPrimaryColor),
            ),
            prefixIcon: Icon(
              widget.icon,
              color: KPrimaryColor,
            ),
            contentPadding: EdgeInsets.all(0),
            errorStyle: TextStyle(color: Colors.grey[700]),
            errorMaxLines: 1,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: KPrimaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: KPrimaryColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: KPrimaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ));
  }
}
