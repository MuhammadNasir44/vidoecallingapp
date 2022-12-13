import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



const primaryColor = Color(0xFF568C48);
var textStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 16.sp);


final textFiledContainerStyle = BoxDecoration(
  color: Colors.grey[300],
  borderRadius: BorderRadius.circular(7),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 3,
      offset: Offset(0, 2),
    ),
  ],
);

final textFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20.h),
  hintText: 'Your message',
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7), borderSide: BorderSide.none),
);
