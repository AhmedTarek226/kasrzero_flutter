import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/constants.dart';

class FilterItem extends StatefulWidget {
  String label;
  Color color;
  Color textColor;
  bool s;
  void Function(String) getlabal;
  FilterItem({
    required this.color,
    required this.label,
    required this.textColor,
    required this.s,
    required this.getlabal,
  });
  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  Color bgColor = Colors.white;
  // bool s = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 2.0, left: 2.0),
      child: FilterChip(
        showCheckmark: false,
        selected: widget.s,
        selectedColor: KPrimaryColor,
        padding: EdgeInsets.all(4.0),
        label: Text(
          widget.label,
          style: TextStyle(color: (widget.s ? Colors.white : widget.textColor)),
        ),
        backgroundColor: bgColor,
        shape: StadiumBorder(
          side: BorderSide(color: widget.color),
        ),
        onSelected: (bool value) {
          if (value) {
            widget.getlabal(widget.label);
            // print(widget.label);
          }
        },
      ),
    );
  }
}
