import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/category.dart';

import '../../models/ad.dart';

class DropList extends StatelessWidget {
  DropList(
      {required this.text,
      // required this.selectedCategory,
      // required this.newAd,
      required this.onChange,
      required this.initValue,
      required this.arr,
      super.key});

  String text;
  // Category selectedCategory;
  // Ad newAd;
  String initValue;
  List arr;
  final Function(dynamic) onChange;
  final mainColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 1.5,
          //   )
          // ],
          color: Colors.grey[200],
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text.toUpperCase(),
            style: TextStyle(
                color: mainColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: DropdownButton(
              value: initValue,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.white,
              iconSize: 20,
              itemHeight: 49,
              underline: Divider(thickness: 1.5, height: 5, color: mainColor),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                // color: KPrimaryColor,
              ),
              menuMaxHeight: 350.h,
              elevation: 2,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp),
              items: arr.map((dynamic items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: TextStyle(color: mainColor),
                  ),
                );
              }).toList(),
              onChanged: (value) => onChange(value),
            ),
          ),
        ],
      ),
    );
  }
}
