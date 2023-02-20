import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yatra/services/location_services.dart';
import 'package:yatra/utils/colors.dart';

class HomeCarousel extends StatefulWidget {
  final List imagePaths;
  final double width;
  final double height;
  const HomeCarousel(
      {super.key,
      required this.imagePaths,
      this.width = 150,
      this.scrollDirection = Axis.horizontal,
      this.height = 150});
  final Axis scrollDirection;

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: widget.scrollDirection,
          itemCount: widget.imagePaths.length,
          itemBuilder: ((context, index) {
            return Cards(
              height: widget.height,
              imagePath: widget.imagePaths[index],
              width: widget.width,
            );
          })),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards(
      {super.key,
      required this.imagePath,
      required this.width,
      required this.height});
  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        elevation: 1,
        child: Stack(
          children: [
            Container(
              height: height.h,
              width: width.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${context.watch<LocationService>().placemarks.last.locality} , \n${context.watch<LocationService>().placemarks.last.country}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: MyColor.whiteColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
