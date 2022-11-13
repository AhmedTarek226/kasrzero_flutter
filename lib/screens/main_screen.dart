import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/screens/MyProfile_screen.dart';
import 'package:kasrzero_flutter/screens/home_screen.dart';
import 'package:kasrzero_flutter/screens/myCart_screen.dart';
import 'package:kasrzero_flutter/screens/myInfo_screen.dart';
import 'package:kasrzero_flutter/screens/myWishlist_screen.dart';
import 'package:kasrzero_flutter/screens/my_account_screen.dart';
import 'package:kasrzero_flutter/screens/post_ad_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _tabIndex = 2;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }
  //rgb(251, 176, 59)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          CircleAvatar(
              backgroundColor: KPrimaryColor,
              child: Icon(Icons.favorite_border_outlined, color: Colors.white)),
          CircleAvatar(
              backgroundColor: KPrimaryColor,
              child: Icon(Icons.shopping_bag_outlined, color: Colors.white)),
          CircleAvatar(
              backgroundColor: KPrimaryColor,
              child: Icon(Icons.home_outlined, color: Colors.white)),
          CircleAvatar(
              backgroundColor: KPrimaryColor,
              child: Icon(Icons.person_outline, color: Colors.white)),
          CircleAvatar(
              backgroundColor: KPrimaryColor,
              child: Icon(Icons.add_circle_outline_sharp, color: Colors.white)),
        ],
        inactiveIcons: const [
          Icon(Icons.favorite_border_outlined, color: KPrimaryColor),
          Icon(Icons.shopping_bag_outlined, color: KPrimaryColor),
          Icon(Icons.home_outlined, color: KPrimaryColor),
          Icon(Icons.person_outline, color: KPrimaryColor),
          Icon(Icons.add_circle_outline_sharp, color: KPrimaryColor),
        ],
        color: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: tabIndex,
        onTab: (v) {
          tabIndex = v;
          pageController.jumpToPage(tabIndex);
        },
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: [
          MyWishlistScreen(),
          MyCartScreen(),
          HomeScreen(),
          MyProfileScreen(),
          PostAdScreen(),
        ],
      ),
    );
  }
}
