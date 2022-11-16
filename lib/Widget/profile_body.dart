import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/screens/MyProfile_screen.dart';
import 'package:provider/provider.dart';

class profileBody extends StatelessWidget {
  const profileBody({super.key});
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 70.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Welcome ${userProvider.user.userName} ,",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            "${userProvider.user.email}",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 25.h),
        ProfileMenu(
          press: () => {Navigator.of(context).pushNamed("/my_info")},
          text: "My Information",
          con: Icons.perm_identity_outlined,
        ),
        ProfileMenu(
          press: () => {Navigator.of(context).pushNamed("/my_ads")},
          text: "My Ads",
          con: Icons.ad_units_outlined,
        ),
        ProfileMenu(
          press: () => {Navigator.of(context).pushNamed("/my_orders")},
          text: "My Orders",
          con: Icons.shopping_cart_outlined,
        ),
        // ProfileMenu(
        //   press: () =>
        //   {
        //     Navigator.of(context).pushNamed("/my_wishlist")
        //   },
        //   text:"My Wishlist" ,
        //   con: Icons.stars_outlined
        //   ),
        ProfileMenu(
          press: () => {
            userProvider.logoutUser(),
            Navigator.pushReplacementNamed(context, '/main'),
          },
          text: "Log Out",
          con: Icons.logout_outlined,
        ),
      ],
    );
  }
}

class profilebodelogin extends StatelessWidget {
  const profilebodelogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150),
        ProfileMenu(
          press: () => {Navigator.of(context).pushNamed("/signup")},
          text: "Sign Up",
          con: Icons.perm_identity_outlined,
        ),
        SizedBox(height: 20.h),
        ProfileMenu(
          press: () => {Navigator.of(context).pushNamed("/signin")},
          text: "Login",
          con: Icons.perm_identity_outlined,
        ),
      ],
    );
  }
}
