import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({super.key});

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll((selectedImages));
    }
    print("First image path: ${selectedImages[0].name}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: imageFileList.length,
                  itemBuilder: ((BuildContext context, index) {
                    return Image.file(
                      File(imageFileList[index].path),
                      fit: BoxFit.cover,
                    );
                  }),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
                child: Text("Pick images"),
                color: Colors.blue,
                onPressed: () {
                  selectImages();
                })
          ],
        ),
      ),
    );
  }
}
