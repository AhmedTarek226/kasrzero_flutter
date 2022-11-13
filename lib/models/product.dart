class Product {
  String id;
  String userId;
  String categoryId;
  String title;
  int price;
  String description;
  String brand;
  String color;
  String durationOfUse;
  List<dynamic> img;
  String status;
  String ableToExchange;
  String firstFilter;
  String secondFilter;
  String thirdFilter;
  List<dynamic> offers;
  String time;
  Product({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.description,
    required this.brand,
    required this.color,
    required this.durationOfUse,
    required this.img,
    required this.status,
    required this.ableToExchange,
    required this.firstFilter,
    required this.secondFilter,
    required this.thirdFilter,
    required this.time,
    required this.offers,
  });
}
