import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.sp),
            bottomRight: Radius.circular(20.sp)),
        color: MyColor.backgroundColor.withOpacity(0.7),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 50.w, top: 10, bottom: 10),
        child: const Icon(
          Icons.arrow_back,
          color: MyColor.greyColor,
        ),
      ),
    );
  }
}
