import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';

class FinishPostAd extends StatelessWidget {
  const FinishPostAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: Image.asset('images/ad_completed.png')),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "Your ad will be reviewed by the team of ksr zero",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DefaultButton(
                      text: "Home Page",
                      press: () {
                        Navigator.pushReplacementNamed(context, '/main');
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
