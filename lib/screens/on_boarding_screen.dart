import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/constants.dart';

import '../Widget/onBoardingScreen/my_page_view.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  Container(
                      height: 120.h,
                      child: Image.asset('images/logo_side.jpeg')),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const MyPageView(),
              ),
              //Slider
              // button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor),
                      color: KPrimaryColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/main');
                      },
                      child: Text(
                        "Go to home page",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
