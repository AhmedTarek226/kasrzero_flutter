import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kasrzero_flutter/constants.dart';

const h4Styleo = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: KPrimaryColor);

class CustomAppBar extends StatelessWidget {
  final String Title;
  bool lead;
  CustomAppBar({required this.Title, this.lead = true});
  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20), vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lead
                ? SizedBox(
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          primary: KPrimaryColor,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                        ),
                        // Navigator.pop(context)
                        onPressed: () => {Navigator.pop(context)},
                        child: Icon(Icons.arrow_back)),
                  )
                : Container(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: lead ? 10.w : 0,
                ),
                child: Text(
                  Title,
                  style: h4Styleo,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
