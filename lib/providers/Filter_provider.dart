import 'package:flutter/material.dart';

class Filtermodel {
  bool state;
  String brand;
  String color;
  String durationOfUse;
  String firstFilter;
  String secondFilter;
  String thirdFilter;
  String colorf;
  RangeValues price;
  Filtermodel({
    required this.state,
    required this.brand,
    required this.color,
    required this.durationOfUse,
    required this.firstFilter,
    required this.secondFilter,
    required this.thirdFilter,
    required this.colorf,
    required this.price,
  });
}

Filtermodel nofilter = Filtermodel(
  state: false,
  brand: "",
  color: "",
  durationOfUse: "",
  firstFilter: "",
  secondFilter: "",
  thirdFilter: "",
  colorf: "",
  price: RangeValues(0, 50000),
);

class FilterProvider with ChangeNotifier {
  Filtermodel filter = nofilter;
  setfilterno() {
    filter = nofilter;
    // notifyListeners();
  }

  setFilter(Filtermodel fil) {
    filter = fil;
    notifyListeners();
  }

  Filtermodel getFilter() {
    return filter;
  }
}
