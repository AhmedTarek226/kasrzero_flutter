import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const Body(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //image
        Container(
          width: double.infinity,
          height: 300.h,
          child: Image.asset('images/$image'),
        ),
        //title
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        //description
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 17.w),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
