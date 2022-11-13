import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kasrzero_flutter/constants.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {required this.labelText,
      required this.onValidate,
      required this.onSave,
      this.inputType = TextInputType.text,
      required this.maxLength,
      this.maxLines = 1,
      required this.inputFormatter,
      required this.containerHeight,
      super.key});

  final mainColor = Colors.black54;
  String labelText;
  Function(dynamic) onSave;
  Function(dynamic) onValidate;
  TextInputType inputType;
  int maxLength;
  int maxLines;
  List<TextInputFormatter> inputFormatter;
  double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: mainColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: TextFormField(
              keyboardType: inputType,
              maxLength: maxLength,
              maxLines: maxLines,
              inputFormatters: inputFormatter,
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
              decoration: InputDecoration(
                label: Text(
                  labelText,
                  style: TextStyle(color: mainColor, fontSize: 14.sp),
                ),
                // prefixIcon: FaIcon(
                //   FontAwesomeIcons.,
                //   color: mainColor,
                // ),
                contentPadding: EdgeInsets.symmetric(vertical: -5.h),
                // focusedBorder: const OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(5)),
                //   borderSide: BorderSide(color: KPrimaryColor),
                // ),
                // errorBorder: OutlineInputBorder(
                //   borderSide: BorderSide(width: 3, color: Colors.red),
                //   // borderRadius: BorderRadius.all(Radius.circular(5)),
                //   // borderSide: BorderSide(color: KPrimaryColor),
                // ),
                // focusedErrorBorder: OutlineInputBorder(
                //   borderSide: BorderSide(width: 3, color: Colors.transparent),
                //   // borderRadius: BorderRadius.all(Radius.circular(5)),
                //   // borderSide: BorderSide(color: KPrimaryColor),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(Radius.circular(5)),
                //   borderSide: BorderSide(color: mainColor),
                // ),
                // border: OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(Radius.circular(5)),
                //   borderSide: BorderSide(color: mainColor),
                // ),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) => onValidate(value),
              onSaved: (value) => onSave(value),
            ),
          ),
        ],
      ),
    );
  }
}
