import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/Widget/onBoardingScreen/body.dart';
import 'package:kasrzero_flutter/Widget/onBoardingScreen/dot_indicator.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  List<Widget> onBoardingData = [
    Container(
      child: Image.asset('images/logo_title.jpeg', fit: BoxFit.contain),
    ),
    const Body(
      title: 'About Us',
      description:
          'We have young and professional delivery team that will bring your food as soon as possible to your doorstep',
      image: 'about_us_screen.png',
    ),
    const Body(
      title: 'Safety',
      description:
          'We are constantly adding your favorite restaurant throughout the territory and arround your area carefully selected',
      image: 'safety_screen.png',
    ),
    const Body(
      title: 'Exchange products',
      description:
          'We are constantly adding your favorite restaurant throughout the territory and arround your area carefully selected',
      image: 'exchange_screen.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 430.h,
          width: double.infinity,
          child: PageView.builder(
            itemCount: 4,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return onBoardingData[index];
            },
          ),
        ),
        DotIndicator(
          pageController: _pageController,
          currentPosition: _currentPageIndex.toDouble(),
          animateTo: _currentPageIndex == 0 ? 1 : 0,
        ),
      ],
    );
  }
}
