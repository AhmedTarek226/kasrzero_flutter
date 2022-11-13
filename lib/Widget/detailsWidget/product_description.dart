import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/models/product.dart';
import 'package:kasrzero_flutter/providers/categories_provider.dart';
import 'package:kasrzero_flutter/services/store.dart';
import 'package:kasrzero_flutter/functions.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
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

  @override
  void initState() {
    super.initState();
  }

  var detailsTitleSytle =
      const TextStyle(fontWeight: FontWeight.w600, color: KPrimaryColor);
  var detailsSytle =
      const TextStyle(fontWeight: FontWeight.w400, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    Category cat = Provider.of<CategoriesProvider>(context)
        .getCategoryById(widget.product.categoryId);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Details",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: KPrimaryColor,
                  fontSize: 18.sp,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Duration Of Use:", style: detailsTitleSytle),
                    Text("Brand :", style: detailsTitleSytle),
                    Text("Color:", style: detailsTitleSytle),
                    Text("${capitalize(cat.titlefirstFilter)} :",
                        style: detailsTitleSytle),
                    Text("${capitalize(cat.titlesecondFilter)} :",
                        style: detailsTitleSytle),
                    Text("${capitalize(cat.titlethirdFilter)} :",
                        style: detailsTitleSytle),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.durationOfUse,
                          overflow: TextOverflow.ellipsis, style: detailsSytle),
                      Text(widget.product.brand,
                          overflow: TextOverflow.ellipsis, style: detailsSytle),
                      Text(widget.product.color,
                          overflow: TextOverflow.ellipsis, style: detailsSytle),
                      Text(widget.product.firstFilter,
                          overflow: TextOverflow.ellipsis, style: detailsSytle),
                      Text(widget.product.secondFilter,
                          overflow: TextOverflow.ellipsis, style: detailsSytle),
                      Text(widget.product.thirdFilter,
                          overflow: TextOverflow.ellipsis, style: detailsSytle),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black12,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: KPrimaryColor,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              widget.product.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: detailsSytle,
            )
          ],
        ),
      ),
    );
  }
}
