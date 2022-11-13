import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kasrzero_flutter/constants.dart';

class FormFieldLogin extends StatefulWidget {
  FormFieldLogin(
      {required this.label,
      required this.icon,
      required this.inputType,
      required this.change,
      this.secure = false,
      super.key});

  String label;
  IconData icon;
  TextInputType inputType;
  Function change;
  bool secure;

  @override
  State<FormFieldLogin> createState() => _FormFieldLoginState();
}

class _FormFieldLoginState extends State<FormFieldLogin> {
  OutlineInputBorder styleBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: const BorderSide(color: KPrimaryColor),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: KPrimaryColor,
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: TextStyle(color: KPrimaryColor, fontSize: 15.sp),
        ),
        prefixIcon: Icon(
          widget.icon,
          size: 20,
          color: KPrimaryColor,
        ),
        suffix: widget.label == "Password" || widget.label == "Confirm Password"
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.secure = !widget.secure;
                  });
                },
                icon: widget.secure == false
                    ? const Icon(
                        Icons.visibility,
                        size: 20,
                        color: KPrimaryColor,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: KPrimaryColor,
                      ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
        focusedBorder: styleBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: styleBorder,
        focusedErrorBorder: styleBorder,
        errorStyle: TextStyle(color: Colors.grey[700]),
      ),
      obscureText: widget.secure,
      keyboardType: widget.inputType,
      inputFormatters: widget.label == "Phone Number"
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      onChanged: (value) => widget.change(value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required !!";
        }
        if (widget.label == "Phone Number" &&
            (value.length != 11 || !value.startsWith('01'))) {
          return "Phone number should be 11 numbers starts with '01' !!";
        }
        return null;
      },
    );
  }
}
