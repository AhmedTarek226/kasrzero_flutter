import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/Widget/Filter_widget/filter_Widget.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/providers/Filter_provider.dart';
import 'package:kasrzero_flutter/providers/categories_provider.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/screens/add_credit_screen.dart';
import 'package:kasrzero_flutter/screens/confirm_order.dart';
import 'package:kasrzero_flutter/screens/finish_offer.dart';
import 'package:kasrzero_flutter/screens/finish_order.dart';
import 'package:kasrzero_flutter/screens/finish_postAd_screen.dart';
import 'package:kasrzero_flutter/screens/my_orders_screen.dart';
import 'package:kasrzero_flutter/screens/product_details_screen.dart';
import 'package:kasrzero_flutter/screens/exchange_products_screen.dart';
import 'package:kasrzero_flutter/screens/home_screen.dart';
import 'package:kasrzero_flutter/screens/main_screen.dart';
import 'package:kasrzero_flutter/screens/myAds_screen.dart';
import 'package:kasrzero_flutter/screens/myCart_screen.dart';
import 'package:kasrzero_flutter/screens/myInfo_screen.dart';
import 'package:kasrzero_flutter/screens/myWishlist_screen.dart';
import 'package:kasrzero_flutter/screens/my_account_screen.dart';
import 'package:kasrzero_flutter/screens/on_boarding_screen.dart';
import 'package:kasrzero_flutter/screens/post_ad_screen.dart';
import 'package:kasrzero_flutter/screens/signin_screen.dart';
import 'package:kasrzero_flutter/screens/signup_screen.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
            lazy: false, create: (context) => CategoriesProvider()),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: ((context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Palette.kToDark,
                  canvasColor: const Color.fromARGB(255, 247, 247, 247),
                ),
                initialRoute: "/",
                routes: {
                  // "/": (context) => OnBoardingScreen(),
                  "/": (context) => const SignInScreen(),
                  "/main": (context) => const MainScreen(),
                  // "/home": (context) => HomeScreen(),
                  "/exchange_products": (context) =>
                      const ExchangeProductsScreen(),
                  "/my_ads": (context) => const MyAdsScreen(),
                  "/my_info": (context) => const MyInfoScreen(),
                  "/my_account": (context) => const MyAccountScreen(),
                  "/my_wishlist": (context) => const MyWishlistScreen(),
                  "/on_boarding": (context) => const OnBoardingScreen(),
                  "/post_ad": (context) => const PostAdScreen(),
                  "/product": (context) => const DetailsScreen(),
                  "/signin": (context) => const SignInScreen(),
                  "/signup": (context) => const SignUpScreen(),
                  "/confirm_order": (context) => const ConfirmOrder(),
                  "/add_credit_card": (context) => AddCreditScreen(),
                  "/Filtre": (context) => Filtre(),
                  "/my_cart": (context) => const MyCartScreen(),
                  '/finish_post_ad': (context) => const FinishPostAd(),
                  '/finish_order': (context) => const FinishOrder(),
                  '/finish_offer': (context) => const FinishOffer(),
                  '/my_orders': (context) => const MyOrdersScreen(),
                })),
      ),
    );
    // ));
  }
}
