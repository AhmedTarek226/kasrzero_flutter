import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/models/product.dart';

import '../../functions.dart';

class MyProductWidget extends StatelessWidget {
  MyProductWidget({required this.myProduct, super.key});
  final Product myProduct;

  // final List products = [];
  // List imgs = [
  //   "public\\img\\img-1667402141004lap1.png",
  //   "public\\img\\img-1667402141009Lark20211104-143537.jpg"
  // ];

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
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            color: Colors.grey[200],
            child: CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
              itemCount: myProduct.img.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                child: Image.network(
                    fit: BoxFit.contain,
                    "http://$KLocalhost/${oneImageFormat(myProduct.img[itemIndex])}"),
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 4.w, right: 4.w),
          child: Text(
            myProduct.title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h, left: 4.w, right: 4.w),
          child: Text(
            "${myProduct.price} EGP",
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
