import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
      this.width = 160,
      this.scrollDirection = Axis.horizontal,
      this.height = 205});
  final Axis scrollDirection;

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.scrollDirection == Axis.vertical
          ? widget.height.h * 1.8
          : widget.height.h,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: widget.scrollDirection,
          itemCount: widget.imagePaths.length,
          itemBuilder: ((context, index) {
            return Cards(
              scrollDirection: widget.scrollDirection,
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
      required this.height,
      required this.scrollDirection});
  final String imagePath;
  final double width;
  final double height;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Material(
            borderRadius: BorderRadius.circular(20.sp),
            elevation: 4,
            child: Container(
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
          ),
          Container(
            height: height.h,
            width: width.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              gradient: LinearGradient(
                stops: [0.1, 0.5, 1.0],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " Machapuchre",
                  style: scrollDirection != Axis.vertical
                      ? Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: MyColor.whiteColor, fontSize: 15.sp)
                      : Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: MyColor.whiteColor, fontSize: 18.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      PhosphorIcons.mapPinFill,
                      color: MyColor.cyanColor,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${context.watch<LocationService>().placemarks.last.locality} , ${context.watch<LocationService>().placemarks.last.country}",
                      style: scrollDirection != Axis.vertical
                          ? Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColor.cyanColor, fontSize: 12.sp)
                          : Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: MyColor.cyanColor, fontSize: 15.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
