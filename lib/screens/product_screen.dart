import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:kasrzero_flutter/services/store.dart';

const h4Styleo = TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: KPrimaryColor);

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  Category cat = Category(
    id: "",
    title: "",
    brands: [],
    titlefirstFilter: "",
    titlesecondFilter: "",
    titlethirdFilter: "",
    optionsfirstFilter: [],
    optionssecondFilter: [],
    optionsthirdFilter: [],
  );
  var ApiCategory = CategoryApi();
  test(String catid) async {
    ApiCategory.getcatbyid(catid).then(((value) => {
          setState(() {
            cat = value;
          }),
          print(value.title),
        }));
  }

  @override
  Widget build(BuildContext context) {
    var pro = ModalRoute.of(context)?.settings.arguments! as Product;
    test(pro.categoryId);
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          pro.title,
          style: const TextStyle(color: KPrimaryColor),
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        shadowColor: null,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Swiper(
              itemBuilder: (context, index) {
                // index = 0;
                final image = pro.img[index];
                return Image.network(
                  "http://10.171.224.78:4000/${image}",
                  fit: BoxFit.contain,
                );
           
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              autoplay: true,
              itemCount: pro.img.length,
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      "Description",
                      style: h4Styleo,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Container(
                      child: Text(pro.description),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 90,
                      width: 400,
                      padding: EdgeInsets.all(5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      "Daitals",
                      style: h4Styleo,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("${cat.titlefirstFilter} :"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("${pro.firstFilter}")
                                ],
                              ),
                              Row(
                                children: [
                                  Text("${cat.titlesecondFilter}:"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("${pro.secondFilter}")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 90,
                      width: 400,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
    ;
  }
}
