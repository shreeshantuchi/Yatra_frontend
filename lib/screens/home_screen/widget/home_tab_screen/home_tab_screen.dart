import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel.dart';
import 'package:yatra/utils/colors.dart';

class HomeTab extends StatefulWidget {
  final List<String> imagePaths;
  HomeTab({super.key, required this.imagePaths});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: MyColor.blackColor),
                  ),
                  Text(
                    "See all",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: MyColor.greyColor, fontSize: 18.sp),
                  ),
                ],
              ),
            ),
            HomeCarousel(imagePaths: widget.imagePaths),
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Perfect for you",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: MyColor.blackColor),
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Text(
                      "See all",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: MyColor.greyColor, fontSize: 18.sp),
                    ),
                  ),
                ],
              ),
            ),
            HomeCarousel(
              height: 233,
              imagePaths: widget.imagePaths,
              width: MediaQuery.of(context).size.width,
              scrollDirection: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }
}
