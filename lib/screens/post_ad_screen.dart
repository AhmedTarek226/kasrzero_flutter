import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/Widget/post_ad/custom_text_form_field.dart';
import 'package:kasrzero_flutter/Widget/post_ad/drop_list.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/models/ad.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/providers/categories_provider.dart';
import 'package:kasrzero_flutter/providers/user_provider.dart';
import 'package:kasrzero_flutter/services/store.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({super.key});

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> {
  Category selectedCategory = Category(
      id: "",
      title: "",
      brands: <String>[],
      titlefirstFilter: "",
      titlesecondFilter: "",
      titlethirdFilter: "",
      optionsfirstFilter: [],
      optionssecondFilter: [],
      optionsthirdFilter: []);

  bool _switchValue = false;
  final _formKey = GlobalKey<FormState>();
  static List<String> durationsOfUse = [
    "Up to 3 months",
    "3 to 6 months",
    "1 year",
    "2 years",
    "3 years",
    "4 years",
    "5 years and more",
  ];
  static List<String> colors = [
    "red",
    "pink",
    "purple",
    "blue",
    "teal",
    "green",
    "lime",
    "yellow",
    "orange",
    "brown",
    "gray",
    "black",
    "white",
    "indigo",
  ];

  bool isLoading = false;
  var _newAd = Ad(
      userId: "",
      categoryId: "",
      title: "",
      price: 0,
      description: "",
      brand: "",
      color: "",
      durationOfUse: "",
      img: [],
      ableToExchange: "false",
      firstFilter: "",
      secondFilter: "",
      thirdFilter: "");

  final list = List.generate((40), (val) => "val $val");
  final ScrollController _controller = new ScrollController();
  var reachEnd = false;

  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;
    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    }

    if (_controller.offset <= minScroll) {
      setState(() {
        reachEnd = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  final _productApi = ProductApi();
  void _saveForm(ctx) async {
    if (_formKey.currentState!.validate()) {
      if (imageFileList!.isEmpty) {
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text("Please pick some images.")));
        return;
      }

      _formKey.currentState!.save();
      final currentUser =
          Provider.of<UserProvider>(ctx, listen: false).getUser();

      setState(() {
        // isLoading = true;
        _newAd.img = imageFileList!;
      });

      var res = await _productApi.PostNewAd(_newAd, "6362890cf85d9a3d675e7927");
      setState(() {
        isLoading = false;
      });
    }
  }

  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];
  void selectImages() async {
    var selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      selectedImages.forEach((image) {
        setState(() {
          imageFileList!.add(File(image.path));
        });
      });
      // imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

  void clearImages() async {
    setState(() {
      imageFileList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories =
        Provider.of<CategoriesProvider>(context).getCategories();
    final currentUser = Provider.of<UserProvider>(context).getUser();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(Title: "Post Ad"),
      ),
      body: currentUser.id == "id"
          ? Center(
              child: Text("login"),
            )
          : isLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: KPrimaryColor,
                    size: 30,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.w,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categories
                                .map(
                                  (category) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = category;
                                        _newAd.categoryId = selectedCategory.id;
                                        _newAd.brand =
                                            selectedCategory.brands[0];
                                        _newAd.color = colors[0];
                                        _newAd.durationOfUse =
                                            durationsOfUse[0];
                                        _newAd.firstFilter = selectedCategory
                                            .optionsfirstFilter[0];
                                        _newAd.secondFilter = selectedCategory
                                            .optionssecondFilter[0];
                                        _newAd.thirdFilter = selectedCategory
                                            .optionsthirdFilter[0];
                                      });
                                      print(category.title);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Chip(
                                        label: Text(category.title),
                                        backgroundColor: category.title ==
                                                selectedCategory.title
                                            ? KPrimaryColor
                                            : Colors.grey[200],
                                        labelStyle: TextStyle(
                                            color: category.title ==
                                                    selectedCategory.title
                                                ? Colors.white
                                                : Colors.grey[700]),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 60.h, top: 10.h),
                              child: Column(
                                children: [
                                  imageFileList!.isNotEmpty
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 3.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 5.h),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 120.h,
                                          child: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: imageFileList!.length,
                                            itemBuilder: ((context, index) {
                                              return Image.file(
                                                File(
                                                    imageFileList![index].path),
                                                fit: BoxFit.cover,
                                              );
                                            }),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 1 / 1,
                                              crossAxisCount: 1,
                                              crossAxisSpacing: 2,
                                              mainAxisSpacing: 2,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 3.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black54)),
                                          height: 120.h,
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey[200])),
                                              onPressed: () => selectImages(),
                                              icon: const Icon(
                                                FontAwesomeIcons.images,
                                                color: Colors.black54,
                                                size: 20,
                                              ),
                                              label: const Text(
                                                "Click to pick images",
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ))),
                                  imageFileList!.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(KPrimaryColor),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  selectImages();
                                                },
                                                child: const Text(
                                                  "Pick more images",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.black45),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  clearImages();
                                                },
                                                child: const Text(
                                                  "Clear all",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CustomTextFormField(
                                      labelText: "Title",
                                      containerHeight: 55.h,
                                      maxLength: 25,
                                      inputFormatter: [
                                        // FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onValidate: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 4) {
                                          return ('');
                                        }
                                        return null;
                                      },
                                      onSave: (value) {
                                        if (value != null) {
                                          _newAd.title = value;
                                        }
                                      }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CustomTextFormField(
                                      labelText: "Price",
                                      containerHeight: 55.h,
                                      maxLength: 7,
                                      inputType: TextInputType.number,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onValidate: (value) {
                                        if (value!.isEmpty || value == 0) {
                                          return ('');
                                        }
                                        return null;
                                      },
                                      onSave: (value) {
                                        if (value != null) {
                                          _newAd.price = int.parse(value);
                                        }
                                        print(_newAd.price);
                                      }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CustomTextFormField(
                                      labelText: "Description",
                                      containerHeight: 130.h,
                                      maxLength: 150,
                                      maxLines: 5,
                                      inputFormatter: const [
                                        // FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onValidate: (value) {
                                        if (value!.isEmpty ||
                                            value.length <= 25) {
                                          return ('');
                                        }
                                        return null;
                                      },
                                      onSave: (value) {
                                        if (value != null) {
                                          _newAd.description = value;
                                        }
                                      }),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 20.h),
                                    child: Row(
                                      children: [
                                        FlutterSwitch(
                                          activeColor: KPrimaryColor,
                                          inactiveColor: Colors.grey,
                                          width: 35.0,
                                          height: 18.0,
                                          // valueFontSize: 5.0,
                                          toggleSize: 16.0,
                                          value: _switchValue,
                                          borderRadius: 40.0,
                                          padding: 0.1,
                                          // showOnOff: true,
                                          onToggle: (val) {
                                            setState(() {
                                              _switchValue = val;
                                              if (val == false)
                                                _newAd.ableToExchange = "false";
                                              if (val == true)
                                                _newAd.ableToExchange = "true";
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "Able to exchange",
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                  selectedCategory.id.isEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.h, bottom: 30.h),
                                          child: Center(
                                            child: Text(
                                              "Choose category to complete your ad",
                                              style: TextStyle(
                                                  color: KPrimaryColor,
                                                  fontSize: 15.sp,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              bottom: 50.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DropList(
                                                      text:
                                                          "Choose brand of product",
                                                      arr: selectedCategory
                                                          .brands,
                                                      initValue:
                                                          _newAd.brand.isEmpty
                                                              ? selectedCategory
                                                                  .brands[0]
                                                              : _newAd.brand,
                                                      onChange: (newValue) {
                                                        setState(() {
                                                          _newAd.brand =
                                                              newValue!;
                                                          print(_newAd.brand);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  DropList(
                                                    text: "Duration of use",
                                                    arr: durationsOfUse,
                                                    initValue: _newAd
                                                            .durationOfUse
                                                            .isEmpty
                                                        ? durationsOfUse[0]
                                                        : _newAd.durationOfUse,
                                                    onChange: (newValue) {
                                                      setState(() {
                                                        _newAd.durationOfUse =
                                                            newValue!;
                                                        print(_newAd
                                                            .durationOfUse);
                                                      });
                                                    },
                                                  ),
                                                  DropList(
                                                    text: "Color",
                                                    arr: colors,
                                                    initValue:
                                                        _newAd.color.isEmpty
                                                            ? colors[0]
                                                            : _newAd.color,
                                                    onChange: (newValue) {
                                                      setState(() {
                                                        _newAd.color =
                                                            newValue!;
                                                        print(_newAd.color);
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DropList(
                                                      text: selectedCategory
                                                          .titlefirstFilter,
                                                      arr: selectedCategory
                                                          .optionsfirstFilter,
                                                      initValue: _newAd
                                                              .firstFilter
                                                              .isEmpty
                                                          ? selectedCategory
                                                              .optionsfirstFilter[0]
                                                          : _newAd.firstFilter,
                                                      onChange: (newValue) {
                                                        setState(() {
                                                          _newAd.firstFilter =
                                                              newValue!;
                                                          print(_newAd
                                                              .firstFilter);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DropList(
                                                      text: selectedCategory
                                                          .titlesecondFilter,
                                                      arr: selectedCategory
                                                          .optionssecondFilter,
                                                      initValue: _newAd
                                                              .secondFilter
                                                              .isEmpty
                                                          ? selectedCategory
                                                              .optionssecondFilter[0]
                                                          : _newAd.secondFilter,
                                                      onChange: (newValue) {
                                                        setState(() {
                                                          _newAd.secondFilter =
                                                              newValue!;
                                                          print(_newAd
                                                              .secondFilter);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: DropList(
                                                      text: selectedCategory
                                                          .titlethirdFilter,
                                                      arr: selectedCategory
                                                          .optionsthirdFilter,
                                                      initValue: _newAd
                                                              .thirdFilter
                                                              .isEmpty
                                                          ? selectedCategory
                                                              .optionsthirdFilter[0]
                                                          : _newAd.thirdFilter,
                                                      onChange: (newValue) {
                                                        setState(() {
                                                          _newAd.thirdFilter =
                                                              newValue!;
                                                          print(_newAd
                                                              .thirdFilter);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              DefaultButton(
                                                  text: "Finish Ad",
                                                  press: () =>
                                                      _saveForm(context)),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
