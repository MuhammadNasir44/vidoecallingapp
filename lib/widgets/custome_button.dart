
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final title;
  final onPressed;
  CustomButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: RaisedButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width, minHeight: 50.h),
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
