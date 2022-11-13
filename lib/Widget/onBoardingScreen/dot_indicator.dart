import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/constants.dart';

class DotIndicator extends StatelessWidget {
  final int animateTo;
  final double currentPosition;

  const DotIndicator({
    Key? key,
    required this.animateTo,
    required this.currentPosition,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              animateTo,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: DotsIndicator(
          dotsCount: 4,
          position: currentPosition,
          decorator: DotsDecorator(
            activeColor: KPrimaryColor,
            size: Size(15.w, 7.h),
            activeSize: Size(15.w, 7.h),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
