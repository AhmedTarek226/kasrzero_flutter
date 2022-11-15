import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/Widget/form_field_login.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:kasrzero_flutter/models/user_login.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/services/auth.dart';
import 'package:kasrzero_flutter/services/user_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final user = UserLogin(email: "", password: "");
  var userAuth = Auth();
  var userService = UserService();
  bool isLoading = false;

  Login(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState?.save();
      // print("in login form func");
      userAuth.Login(user).then((value) async {
        // print(value.body);
        if (value.body == "failed") {
          ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content: Text("Please enter correct information")));
        } else {
          // print(value.body);
          UserData currentUser = await userService.getUser(user.email);
          print(currentUser.email);
          Provider.of<UserProvider>(ctx, listen: false).setUser(currentUser);
          Navigator.pop(ctx);
        }
        setState(() {
          isLoading = false;
        });

        // print(value.body);
        // Navigator.pushReplacementNamed(context, "/home");
        // print(value.headers);
      }).catchError((err) => print("err"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: CustomAppBar(Title: "Login Form"),
          ),
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
                            // height: 100,
                            width: double.infinity,
                            child: Image.asset('images/signinn.png')),
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
                          height: 18.h,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  KPrimaryColor)),
                          onPressed: () {
                            setState(() {
                              Login(context);
                            });
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/signup');
                              },
                              child: Text(
                                'Sign Up',
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
