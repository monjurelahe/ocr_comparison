import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const whiteColor = Colors.white;
const greyColor = Colors.white;
const blackColor = Colors.black;

//TextStyles
TextStyle headingText(textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 18.sp,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
  );
}

TextStyle descriptionText(textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
}

//TextFormFields
InputDecoration appInputDecoration(label) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    fillColor: whiteColor,
    contentPadding: EdgeInsets.all(11),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26),
    ),
    border: OutlineInputBorder(),
    labelText: label,
  );
}

//Button STyle
ButtonStyle appButton() {
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: EdgeInsets.zero,
    backgroundColor: Colors.amber,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(11),
    ),
  );
}

//Button er Text Style
TextStyle buttonTextStyle() {
  return TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Inter',
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
}

//Button er height-width
Ink buttonColor(String buttonText) {
  return Ink(
    decoration: BoxDecoration(
      color: greyColor,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Container(
      height: 44.h,
      alignment: Alignment.center,
      child: Text(buttonText, style: buttonTextStyle()),
    ),
  );
}

//Linear Button
Ink linearButton(String buttonText) {
  return Ink(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff003366), Color(0xff228b22)],
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(11),
    ),
    child: Container(
      height: 44.h,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: buttonTextStyle(),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
