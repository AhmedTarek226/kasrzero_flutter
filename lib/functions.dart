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


// String imageFormat(String oldImage) {
//   String letter = "\\";
//   String newLetter = "//";
//   // List newImages = [];
//   return oldImage.replaceAll(letter, newLetter);
  
// }
