import 'package:kasrzero_flutter/constants.dart';

String capitalize(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " " && cap == true) {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
      cap = false;
    }
  }
  return result;
}

List imageFormat(List oldImages) {
  String letter = "\\";
  String newLetter = "//";
  List newImages = [];
  for (int i = 0; i < oldImages.length; i++) {
    String newImg = oldImages[i].replaceAll(letter, newLetter);
    newImages.add(newImg);
  }
  return newImages;
}

String oneImageFormat(String oldImage) {
  String letter = "\\";
  String newLetter = "//";
  // List newImages = [];
  return oldImage.replaceAll(letter, newLetter);
}

int getTotal(int price) {
  return price + getTaxes(price) + shipping;
}

int getTaxes(int price) {
  if (price >= 1 && price < 500) {
    return (price * 10 / 100).round();
  } else if (price >= 500 && price < 2000) {
    return (price * 8 / 100).round();
  } else if (price >= 2000 && price < 5000) {
    return (price * 7 / 100).round();
  } else if (price >= 5000 && price < 10000) {
    return (price * 6 / 100).round();
  } else if (price >= 10000 && price < 15000) {
    return (price * 5 / 100).round();
  } else if (price >= 15000 && price < 25000) {
    return (price * 2.5 / 100).round();
  } else if (price >= 25000 && price < 35000) {
    return (price * 1.5 / 100).round();
  } else {
    return (price * 1 / 100).round();
  }
}

int getTotalOfferCost(int price1, int price2) {
  int diff = price2 - price1;
  int taxes = getTaxes(price1);
  int total = 0;
  if (diff > 0) {
    if (diff >= (shipping + taxes)) {
      total = diff - (shipping + taxes);
    } else {
      total = (shipping + taxes) - diff;
    }
  } else if (diff < 0) {
    total = (diff * -1) + shipping + taxes;
  } else {
    total = shipping + taxes;
  }
  return total;
}
