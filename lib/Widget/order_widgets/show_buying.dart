import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kasrzero_flutter/Widget/card_widget.dart';
import '../../constants.dart';
import '../../functions.dart';

class ShowBuyingOrder extends StatelessWidget {
  const ShowBuyingOrder({required this.order, super.key});
  final order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order['id'], style: h4Style),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1.5,
                ),
                SizedBox(height: 5.h),
                Text(
                  order['product']['title'],
                  style: h5Style.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 13.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  "${order['product']['price']} EGP",
                  style: h5Style.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 13.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: order['status'] == "delivered"
                          ? Colors.black87
                          : KPrimaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    order['status'],
                    style: h5Style.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: KPrimaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Buying Order",
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
