import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:kasrzero_flutter/models/product.dart';

class OfferWidget extends StatefulWidget {
  Product product;
  OfferWidget({required this.product, super.key});

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  String? offer;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      surfaceTintColor: KPrimaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: KPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              // child: Text("asdlj"),
              height: 150.h,
              width: 150.w,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Text(
                      capitalize("Used 3 years"),
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      capitalize("mobile & tablet"),
                      style: TextStyle(color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      capitalize("red"),
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Text(
                      "13000 EGP",
                      style: TextStyle(
                          color: KPrimaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 30.w,
              child: Radio(
                value: widget.product.id,
                groupValue: offer,
                toggleable: true,
                
                activeColor: KPrimaryColor,
                focusColor: KPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    offer = value.toString();
                    print(offer);
                  });
                  // print(selected); //selected value
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
