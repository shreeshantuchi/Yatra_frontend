import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingCarousel extends StatefulWidget {
  final List imagePaths;
  const LandingCarousel({super.key, required this.imagePaths});

  @override
  State<LandingCarousel> createState() => _LandingCarouselState();
}

class _LandingCarouselState extends State<LandingCarousel> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Stack(children: [
        CarouselSlider.builder(
            options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 0.7,
                initialPage: 1,
                onPageChanged: (index, reason) => setState(
                      (() => activeIndex = index),
                    )),
            itemCount: widget.imagePaths.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Cards(
                imagePath: widget.imagePaths[itemIndex],
              );
            }),
        Positioned(
          left: MediaQuery.of(context).size.width.w / 2.8.w,
          top: MediaQuery.of(context).size.height.h / 1.35.h,
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: 3,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.white.withOpacity(0.4)),
          ),
        ),
      ]),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.sp),
        bottomRight: Radius.circular(10.sp),
      ),
      child: Image.asset(
        imagePath,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
