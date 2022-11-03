import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/screens/category_screen.dart';
import 'package:kasrzero_flutter/screens/exchange_products_screen.dart';
import 'package:kasrzero_flutter/screens/home_screen.dart';
import 'package:kasrzero_flutter/screens/myAds_screen.dart';
import 'package:kasrzero_flutter/screens/myInfo_screen.dart';
import 'package:kasrzero_flutter/screens/myWishlist_screen.dart';
import 'package:kasrzero_flutter/screens/on_boarding_screen.dart';
import 'package:kasrzero_flutter/screens/post_ad_screen.dart';
import 'package:kasrzero_flutter/screens/product_screen.dart';
import 'package:kasrzero_flutter/screens/signin_screen.dart';
import 'package:kasrzero_flutter/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // This is sample of provider

          // ChangeNotifierProvider<UserProvider>(
          //   create: (context) => UserProvider(),
          // ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: ((context, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                  ),
                  initialRoute: "/",
                  routes: {
                    // "/":(context)=> OnBoardingScreen(),
                    "/": (context) => const HomeScreen(),
                    "/category": (context) => const CategoryScreen(),
                    "/exchange_products": (context) =>
                        const ExchangeProductsScreen(),
                    "/my_ads": (context) => const MyAdsScreen(),
                    "/my_info": (context) => const MyInfoScreen(),
                    "/my_wishlist": (context) => const MyWishlistScreen(),
                    "/on_boarding": (context) => const OnBoardingScreen(),
                    "/post_ad": (context) => const PostAdScreen(),
                    "/product": (context) => const ProductScreen(),
                    "/signin": (context) => const SignInScreen(),
                    "/signup": (context) => const SignUpScreen(),
                  })),
        ));
  }
}
