import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../functions.dart';

class MyProductWidget extends StatelessWidget {
  MyProductWidget({super.key});

  final List products = [];
  List imgs = [
    "public\\img\\img-1667402141004lap1.png",
    "public\\img\\img-1667402141009Lark20211104-143537.jpg"
  ];

  // final cc = {
  //   "first": {"title": "", "options": []}
  // };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      // color: KPrimaryColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            height: 195.h,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
              itemCount: imgs.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                child: Image.network(
                    fit: BoxFit.contain,
                    "http://$KLocalhost/${imageFormat(imgs[itemIndex])}"),
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 4.w, right: 4.w),
          child: Text(
            "Iphone 13 pro max 256 GBasdas dfeasfasa sdsdfefef efw fwe",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
          child: Text(
            "19500 EGP",
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: KPrimaryColor),
          ),
        ),
      ]),
    );
  }
}
