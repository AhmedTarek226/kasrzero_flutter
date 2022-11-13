import 'package:flutter/cupertino.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/services/store.dart';

class CategoriesProvider with ChangeNotifier {
  CategoriesProvider() {
    setCategories();
  }
  List<Category> categories = [];
  CategoryApi categoryApi = CategoryApi();

  void setCategories() async {
    categories = await categoryApi.getcat();
    print(categories);
    notifyListeners();
  }

  List<Category> getCategories() {
    return [...categories];
  }

  Category getCategoryById(String id) {
    return categories.firstWhere((element) => element.id == id);
  }
}
