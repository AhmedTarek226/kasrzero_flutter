import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/Widget/profile_body.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_svg/svg.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  backgroundColor: Colors.grey.shade300,
);

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.getUser();
    return currentUser.id != "id" ? profileBody() : profilebodelogin();
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.con,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;
  final IconData con;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey[300])),
        // style: flatButtonStyle,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              Icon(con, size: 30, color: KPrimaryColor),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black26,
              )
            ],
          ),
        ),
      ),
    );
  }
}
