class Category {
  String id;
  String title;
  List<dynamic> brands;
  String titlefirstFilter;
  String titlesecondFilter;
  String titlethirdFilter;
  List optionsfirstFilter;
  List optionssecondFilter;
  List optionsthirdFilter;
  Category({
    required this.id,
    required this.title,
    required this.brands,
    required this.titlefirstFilter,
    required this.titlesecondFilter,
    required this.titlethirdFilter,
    required this.optionsfirstFilter,
    required this.optionssecondFilter,
    required this.optionsthirdFilter,
  });
}
