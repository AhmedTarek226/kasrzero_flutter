import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 10.h,
          width: 20.w,
          child:
              Center(child: Text("hello", style: TextStyle(fontSize: 15.sp)))),
    );
  }
}
