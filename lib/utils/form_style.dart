import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/utils/colors.dart';

class FormStyle {
  static InputDecoration signUpStyle(
      {required BuildContext context, required String hintText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(width: 1.w, color: MyColor.whiteColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(width: 2.w, color: MyColor.whiteColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 1.w,
          color: MyColor.whiteColor.withOpacity(0.5),
        ),
      ),
      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: MyColor.whiteColor.withOpacity(0.5),
          ),
    );
  }
}
