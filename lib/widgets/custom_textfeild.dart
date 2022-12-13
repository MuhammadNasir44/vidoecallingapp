import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatelessWidget {
  final onChanged;
  final obsecure;
  final validator;
  final lableText;
  final hintText;
  final controller;
  final preFixIcon;
  final sufFixIcon;
  final textInputAction;
  final keyBoardType;

  CustomTextField({
    this.preFixIcon,
    this.hintText,
    this.obsecure,
    this.sufFixIcon,
    this.onChanged,
    this.controller,
    this.lableText,
    this.validator,
    this.textInputAction,
    this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      height: 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(
            color: Color(0xffE8E8E8),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(preFixIcon),
          Expanded(
            child: Container(
              // decoration: textFiledContainerStyle,
              child: TextFormField(
                obscuringCharacter: '*',
                obscureText: obsecure,
                cursorColor: Colors.black,
                textInputAction: textInputAction,
                keyboardType: keyBoardType,
                onChanged: onChanged,
                validator: validator,
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  suffixIcon: sufFixIcon,
                  hintText:  '$hintText',
                  fillColor: Colors.white,
                  filled: true,
                   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelText: lableText,
                  labelStyle: TextStyle(color: Colors.grey,fontSize: 14.sp),
                  border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
