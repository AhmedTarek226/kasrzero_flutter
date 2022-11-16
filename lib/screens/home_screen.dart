import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/Widget/Category_tap.widget.dart';
import 'package:kasrzero_flutter/Widget/card_widget.dart';

import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:kasrzero_flutter/providers/Filter_provider.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/services/store.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:textfield_search/textfield_search.dart';

import '../models/user_data.dart';
// import 'package:textfield_search/textfield_search.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.currentUser, super.key});
  UserData currentUser;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var ApiCategory = CategoryApi();
  var Apiproduct = ProductApi();
  var user = UserProvider();
  String SelectedCategory = "";
  List<Category> cat = [];
  List<Product> pro = [];
  List<Product> catpro = [];
  List<Product> pro1 = [];
  List<String> search = [];
  Category fcat = new Category(
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
  Category catAll = new Category(
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
  bool cats = false;
  @override
  void initState() {
    ApiCategory.getcat().then((value) {
      setState(() {
        cat = value;
      });
    });
    Apiproduct.getpro().then((value) {
      for (var ad in widget.currentUser.ads) {
        value.removeWhere((element) => element.id == ad);
      }
      setState(() {
        pro = value;
        pro1 = value;
      });
    });
  }

  void Allcat(String id) {
    // print(id);
    fcat = catAll;
    setState(() {
      pro = pro1;
      SelectedCategory = "";
    });
  }

  void getcatpro(String id) {
    catpro = pro1.where((element) => element.categoryId == id).toList();
    fcat = cat.singleWhere((element) => element.id == id);
    setState(() {
      pro = catpro;
      SelectedCategory = id;
    });
  }

  TextEditingController textControllers = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final filterprovider = Provider.of<FilterProvider>(context);
    Filtermodel fil = filterprovider.getFilter();
    if (fil.state) {
      if (SelectedCategory == "") {
        List<Product> f = pro1
            .where((element) =>
                (fil.brand != "" ? (element.brand == fil.brand) : (true)) &&
                (fil.durationOfUse != ""
                    ? (element.description == fil.durationOfUse)
                    : (true)) &&
                (fil.firstFilter != ""
                    ? (element.firstFilter == fil.firstFilter)
                    : (true)) &&
                (fil.secondFilter != ""
                    ? (element.secondFilter == fil.secondFilter)
                    : (true)) &&
                (fil.thirdFilter != ""
                    ? (element.thirdFilter == fil.thirdFilter)
                    : (true)) &&
                (fil.colorf != "" ? (element.color == fil.colorf) : (true)) &&
                (fil.price != RangeValues(0, 50000)
                    ? (element.price >= fil.price.start.toInt() &&
                        element.price <= fil.price.end.toInt())
                    : (true)))
            .toList();
        setState(() {
          pro = f;
        });
        filterprovider.setfilterno();
      } else {
        List<Product> c = catpro
            .where((element) =>
                (fil.brand != "" ? (element.brand == fil.brand) : (true)) &&
                (fil.durationOfUse != ""
                    ? (element.description == fil.durationOfUse)
                    : (true)) &&
                (fil.firstFilter != ""
                    ? (element.firstFilter == fil.firstFilter)
                    : (true)) &&
                (fil.secondFilter != ""
                    ? (element.secondFilter == fil.secondFilter)
                    : (true)) &&
                (fil.thirdFilter != ""
                    ? (element.thirdFilter == fil.thirdFilter)
                    : (true)) &&
                (fil.colorf != "" ? (element.color == fil.colorf) : (true)) &&
                (fil.price != RangeValues(0, 50000)
                    ? (element.price >= fil.price.start.toInt() &&
                        element.price <= fil.price.end.toInt())
                    : (true)))
            .toList();
        setState(() {
          pro = c;
        });
        filterprovider.setfilterno();
      }
    } else {}
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBarAnimation(
                      searchBoxWidth: 290,
                      textEditingController: textControllers,
                      isOriginalAnimation: false,
                      buttonBorderColour: Colors.black45,
                      buttonWidget: Icon(Icons.search),
                      secondaryButtonWidget: Icon(Icons.arrow_back),
                      trailingWidget: Icon(Icons.close),
                      onChanged: (String value) {
                        if (SelectedCategory == "") {
                          List<Product> sear = pro1.where((element) {
                            final tital = element.title.toLowerCase();
                            final inpout = value.toLowerCase();
                            return tital.contains(inpout);
                          }).toList();
                          setState(() {
                            pro = sear;
                          });
                        } else {
                          List<Product> sear = catpro.where((element) {
                            final tital = element.title.toLowerCase();
                            final inpout = value.toLowerCase();
                            return tital.contains(inpout);
                          }).toList();
                          setState(() {
                            pro = sear;
                          });
                        }
                      },
                      onFieldSubmitted: (String value) {
                        List<Product> sear = pro1
                            .where((element) => element.title == value)
                            .toList();
                        setState(() {
                          pro = sear;
                        });
                      }),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    child: Stack(clipBehavior: Clip.none, children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          color: KPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                    onTap: () => {
                      Navigator.of(context)
                          .pushNamed("/Filtre", arguments: fcat),
                      // print(fcat.optionsfirstFilter),
                      // print(fcat.optionssecondFilter),
                    },
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(scrollDirection: Axis.horizontal, children: [
              CategoryTap(
                color: Colors.white,
                label: "ALL",
                textColor:
                    (SelectedCategory == "") ? Colors.white : Colors.grey,
                cat: fcat,
                getcat: Allcat,
                s: (SelectedCategory == "") ? true : false,
              ),
              ...cat
                  .map((e) => CategoryTap(
                        color: Colors.white,
                        label: e.title,
                        textColor: (SelectedCategory == e.id)
                            ? Colors.white
                            : Colors.grey,
                        cat: e,
                        getcat: getcatpro,
                        s: (SelectedCategory == e.id) ? true : false,
                      ))
                  .toList()
            ])),
            pro1.isNotEmpty
                ? pro.isEmpty
                    ? Expanded(
                        flex: 7, child: Center(child: Text("No Results")))
                    : Expanded(
                        flex: 7,
                        child: FurnitureListView(
                          ProductList: pro,
                          isHorizontal: false,
                          onTap: (Product) {
                            print(Product.title);
                            Navigator.of(context)
                                .pushNamed("/product", arguments: Product);
                          },
                        ))
                : Expanded(
                    flex: 7,
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: KPrimaryColor,
                        size: 30,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
