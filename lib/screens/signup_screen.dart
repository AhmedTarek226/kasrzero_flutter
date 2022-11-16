import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/Widget/form_field_login.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/user_signup.dart';
import 'package:kasrzero_flutter/services/auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/user_data.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String confirm = "";
  final user =
      UserSignup(email: "", password: "", phoneNumber: "", userName: "");
  var userAuth = Auth();
  var userService = UserService();
  bool isLoading = false;

  Signup(ctx) {
    if (_formKey.currentState!.validate()) {
      if (user.password == confirm) {
        setState(() {
          isLoading = true;
        });
        _formKey.currentState?.save();

        userAuth.Signup(user).then((value) async {
          setState(() {
            isLoading = false;
          });
          if (value.body == "failed") {
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                content: Text("Please enter correct information")));
          } else {
            UserData currentUser = await userService.getUser(user.email);
            print(currentUser.email);
            Provider.of<UserProvider>(ctx, listen: false).setUser(currentUser);
            Navigator.pushReplacementNamed(context, '/main');
          }
        }).catchError((err) {
          setState(() {
            isLoading = false;
          });
          print("error");
        });
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text("Confirm password should be same as password")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: KPrimaryColor,
                    size: 30,
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: ListView(
                      children: [
                        Container(
                            color: Colors.white,
                            height: 150.h,
                            width: double.infinity,
                            child: Image.asset('images/signup.png')),
                        FormFieldLogin(
                          label: "User Name",
                          icon: Icons.person,
                          inputType: TextInputType.name,
                          change: (value) {
                            user.userName = value;
                          },
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        FormFieldLogin(
                          label: "Phone Number",
                          icon: Icons.phone,
                          inputType: TextInputType.number,
                          change: (value) {
                            user.phoneNumber = value;
                          },
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        FormFieldLogin(
                          label: "Email",
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          change: (value) {
                            user.email = value;
                          },
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        FormFieldLogin(
                          label: "Password",
                          icon: Icons.password,
                          inputType: TextInputType.text,
                          secure: true,
                          change: (value) {
                            user.password = value;
                          },
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        FormFieldLogin(
                          label: "Confirm Password",
                          icon: Icons.password,
                          inputType: TextInputType.text,
                          secure: true,
                          change: (value) {
                            confirm = value;
                          },
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  KPrimaryColor)),
                          onPressed: () {
                            setState(() {
                              Signup(context);
                            });
                          },
                          child: Text("Sign up",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'I have an account ',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/signin');
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: KPrimaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))),
    );
  }
}
