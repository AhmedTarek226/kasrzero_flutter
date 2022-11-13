import 'package:flutter/material.dart';

import '../../../../constants.dart';

// class ColorDots extends StatelessWidget {
//   const ColorDots({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Now this is fixed and only for demo
//     int selectedColor = 3;
//     return
//           ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               ColorDot(color: Colors.black),
//               ColorDot(color: Colors.white),
//               ColorDot(color: Colors.grey),
//               ColorDot(color: Colors.red),
//               ColorDot(color: Colors.blueGrey),
//               ColorDot(color: Colors.yellow),
//               ColorDot(color: Colors.green),
//             ],
//     );
//   }
// }

class ColorDote extends StatefulWidget {
  Color color;
  bool s;
  String label;
  void Function(String) getlabal;
  ColorDote({
    Key? key,
    required this.label,
    required this.color,
    required this.s,
    required this.getlabal,
  }) : super(key: key);

  @override
  State<ColorDote> createState() => _ColorDoteState();
}

class _ColorDoteState extends State<ColorDote> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onSelected: (bool values) {
        if(values){
          widget.getlabal(widget.label);
        }
          // print(widget.label);
      },
      showCheckmark: false,
      selected: widget.s,
      backgroundColor:Colors.transparent ,
      selectedColor:Colors.transparent ,
      label: Container(
        // margin: EdgeInsets.only(right: 2),
        // padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        height: getProportionateScreenWidth(30),
        width: getProportionateScreenWidth(30),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: widget.s ? Colors.orangeAccent : Colors.transparent,width: 2),
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
    
  }
}
