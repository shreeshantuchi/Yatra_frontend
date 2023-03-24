import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/models/food_model.dart';

import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';

class HomeCarouselShimmer extends StatefulWidget {
  final double width;
  final double height;

  const HomeCarouselShimmer({
    super.key,
    this.width = 160,
    this.scrollDirection = Axis.horizontal,
    this.height = 215,
  });
  final Axis scrollDirection;

  @override
  State<HomeCarouselShimmer> createState() => _HomeCarouselShimmerState();
}

class _HomeCarouselShimmerState extends State<HomeCarouselShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.scrollDirection == Axis.vertical
          ? widget.height.h * 1.8
          : widget.height.h,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: widget.scrollDirection,
          itemCount: 3,
          itemBuilder: ((context, index) {
            return CardsShimmer(
              scrollDirection: widget.scrollDirection,
              height: widget.height,
              width: widget.width,
            );
          })),
    );
  }
}

class CardsShimmer extends StatelessWidget {
  const CardsShimmer({
    super.key,
    required this.width,
    required this.height,
    required this.scrollDirection,
  });

  final double width;
  final double height;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.3),
            highlightColor: Colors.grey.withOpacity(0.6),
            child: Container(
              height: height.h,
              width: width.w,
              decoration: BoxDecoration(
                  color: MyColor.greyColor,
                  borderRadius: BorderRadius.circular(20.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
