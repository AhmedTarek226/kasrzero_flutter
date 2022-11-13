import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Ad {
  String userId;
  String categoryId;
  String title;
  int price;
  String description;
  String brand;
  String color;
  String durationOfUse;
  List<File> img;
  String ableToExchange;
  String firstFilter;
  String secondFilter;
  String thirdFilter;

  Ad({
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.description,
    required this.brand,
    required this.color,
    required this.durationOfUse,
    required this.img,
    required this.ableToExchange,
    required this.firstFilter,
    required this.secondFilter,
    required this.thirdFilter,
  });
}
