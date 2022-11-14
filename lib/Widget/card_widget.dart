import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/product.dart';

const h1Style = TextStyle(
    fontSize: 60,
    color: Colors.black,
    fontFamily: "Poppins",
    height: 1.4,
    fontWeight: FontWeight.w900);

const h2Style = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600);

const h3Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black);

const h4Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black);
const h4Styleo = TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.orangeAccent);
const h5Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Colors.black);

class FurnitureListView extends StatelessWidget {
  final bool isHorizontal;
  final String isslected;
  final Function(Product Product)? onTap;
  final List<Product> ProductList;

  const FurnitureListView(
      {Key? key,
      this.isHorizontal = true,
      this.onTap,
      this.isslected = "",
      required this.ProductList})
      : super(key: key);

  Widget _furnitureImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.network(
        'http://$KLocalhost/${image}',
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _listViewItem(Product product, int index , String idpro) {
    Widget widget;
    widget = isHorizontal == true
        ? Column(
            children: [
              Hero(tag: index, child: _furnitureImage(product.img[0])),
              const SizedBox(height: 10),
              Text(product.title, style: h4Style)
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: (isslected==idpro?Colors.orangeAccent:Colors.transparent)),
                borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _furnitureImage(product.img[0]),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, style: h4Style),
                            const SizedBox(height: 5),
                            Text(
                              product.description,
                              style: h5Style.copyWith(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${product.price} EGP',
                              style: h4Styleo,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

    return GestureDetector(
      onTap: () => onTap?.call(product),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isHorizontal == true
        ? SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ProductList.length,
              itemBuilder: (_, index) {
                Product furniture = ProductList[index];
                return _listViewItem(furniture, index,furniture.id);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.only(left: 15),
                );
              },
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            reverse: false,
            physics: const ClampingScrollPhysics(),
            itemCount: ProductList.length,
            itemBuilder: (_, index) {
              Product product = ProductList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child:  _listViewItem(product, index,product.id),
              );
            },
          );
  }
}