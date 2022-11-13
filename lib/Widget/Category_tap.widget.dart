import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/models/category.dart';

class CategoryTap extends StatefulWidget {
  String label;
  Color color;
  Color textColor;
  Category cat;
  bool s;
  void Function(String) getcat;
  CategoryTap({
    required this.color,
    required this.label,
    required this.textColor,
    required this.cat,
    required this.getcat,
    required this.s,
  });

  @override
  State<CategoryTap> createState() => _CategoryTapState();
}

class _CategoryTapState extends State<CategoryTap> {
  Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 2.0, left: 2.0),
      child: FilterChip(
        selected: widget.s,
        selectedColor: Colors.orangeAccent,
        showCheckmark: false,
        padding: EdgeInsets.all(4.0),
        label: Text(
          widget.label,
          style: TextStyle(color: widget.textColor),
        ),
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(color: widget.color),
        ),
        onSelected: (bool value) {
          if (value) {
            widget.getcat(widget.cat.id);
          }
          print(value);
          setState(() {
            // widget.s = value;
          });
        },
      ),
    );
  }
}
