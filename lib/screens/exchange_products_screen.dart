import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/dummy_data.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/services/store.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Widget/detailsWidget/custom_app_bar.dart';
import '../Widget/exchange_products_widgets/my_product_widget.dart';
import '../functions.dart';

class ExchangeProductsScreen extends StatefulWidget {
  const ExchangeProductsScreen({super.key});

  @override
  State<ExchangeProductsScreen> createState() => _ExchangeProductsScreenState();
}

class _ExchangeProductsScreenState extends State<ExchangeProductsScreen> {
  List<Product> products = Dummy_products;
  String offer = "";
  final productsStore = ProductApi();
  // final productId = "6362894c3dcf675a3e09b2f0";
  bool isLoading = false;
  int difference = 0;
  // final product = Dummy_products[0];

  @override
  void initState() {
    // getOffers();
    // setState(() {
    //   isLoading = false;
    // });
    super.initState();
  }

  // getOffers() async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   List<Product> prods = await productsStore.getOffers(widget.product.id);
  //   setState(() {
  //     products = prods;
  //     offer = products[0].id;
  //     difference = widget.product.price - products[0].price;
  //     // isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Product> products =
        ModalRoute.of(context)!.settings.arguments as List<Product>;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(
            Title: "Available offers",
          ),
        ),
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: KPrimaryColor,
                  size: 30,
                ),
              )
            : Column(
                children: [
                  MyProductWidget(myProduct: products[0]),
                  Divider(
                    height: 10.h,
                    color: KPrimaryColor,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          borderOnForeground: false,
                          surfaceTintColor: KPrimaryColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  height: 150.h,
                                  width: 150.w,
                                  child: Image.network(
                                      fit: BoxFit.contain,
                                      "http://$KLocalhost/${oneImageFormat(products[index + 1].img[0])}"),
                                ),
                                Flexible(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index + 1].title,
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
                                          products[index + 1].durationOfUse,
                                          // capitalize("Used 3 years"),
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          products[index + 1].categoryId,
                                          style:
                                              TextStyle(color: Colors.black54),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          products[index + 1].color,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        SizedBox(
                                          height: 11.h,
                                        ),
                                        Text(
                                          "${products[index + 1].price} EGP",
                                          style: TextStyle(
                                              color: KPrimaryColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                  height: 30.h,
                                  child: Radio(
                                    value: products[index + 1].id,
                                    groupValue: offer,
                                    // toggleable: true,
                                    activeColor: KPrimaryColor,
                                    focusColor: KPrimaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        offer = value.toString();
                                        difference = products[0].price -
                                            products[index + 1].price;
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
                      },
                      itemCount: products.length - 1,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      color: Colors.black87,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            // color: Colors.black,
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Difference: $difference EGP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 150.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  KPrimaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: const Text("Accept offer"),
                            onPressed: () {
                              if (offer != "") {
                                Product selectedProduct = products.firstWhere(
                                    (element) => element.id == offer);
                                Navigator.pushNamed(context, "/confirm_order",
                                    arguments: [
                                      products[0],
                                      selectedProduct,
                                      false
                                    ]);
                              }

                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return AlertDialog(
                              //       title: Text('Accept this offer ?'),
                              //       content: Container(
                              //         height: 100.h,
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: const [
                              //                 Text(
                              //                   'Product price: ',
                              //                 ),
                              //                 Text(
                              //                   'Difference: ',
                              //                 ),
                              //                 Text(
                              //                   'Shipping: ',
                              //                 ),
                              //                 Text(
                              //                   'Taxes: ',
                              //                 ),
                              //               ],
                              //             ),
                              //             Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   '14000 EGP',
                              //                 ),
                              //                 Text(
                              //                   '2000 EGP',
                              //                 ),
                              //                 Text(
                              //                   '50 EGP',
                              //                 ),
                              //                 Text(
                              //                   '100 EGP',
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       actions: <Widget>[
                              //         ElevatedButton(
                              //           style: ButtonStyle(
                              //               backgroundColor:
                              //                   MaterialStateProperty.all(
                              //                       KPrimaryColor)),
                              //           child: const Text('Cancel'),
                              //           onPressed: () {
                              //             Navigator.of(context).pop();
                              //           },
                              //         ),
                              //         ElevatedButton(
                              //           style: ButtonStyle(
                              //               backgroundColor:
                              //                   MaterialStateProperty.all(
                              //                       Colors.black87)),
                              //           child: const Text('Confirm'),
                              //           onPressed: () {
                              //             Product selectedProduct =
                              //                 products.firstWhere((element) =>
                              //                     element.id == offer);
                              //             Navigator.pushNamed(
                              //                 context, "/confirm_order",
                              //                 arguments: ScreenArguments(
                              //                     currentProduct: products[0],
                              //                     selectedProduct:
                              //                         selectedProduct));
                              //           },
                              //         )
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ScreenArguments {
  final Product currentProduct;
  final Product selectedProduct;

  ScreenArguments(
      {required this.currentProduct, required this.selectedProduct});
}
