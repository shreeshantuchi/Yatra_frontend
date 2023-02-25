import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/services/location_services.dart';
import 'package:yatra/utils/colors.dart';

import 'package:yatra/widget/background.dart';

class DetailDscriptionScreen extends StatefulWidget {
  const DetailDscriptionScreen({
    super.key,
  });

  @override
  State<DetailDscriptionScreen> createState() => _DetailDscriptionScreenState();
}

class _DetailDscriptionScreenState extends State<DetailDscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mapArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int index = mapArguments["index"];
    List<String> imgList = mapArguments["imgList"];

    return customBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Column(
            children: [
              ImageSlider(
                i: index,
                imgList: imgList,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    headingRow(),
                    SizedBox(
                      height: 10.h,
                    ),
                    rateReviewRow(),
                    SizedBox(
                      height: 10.h,
                    ),
                    descriptionText(
                        description:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget headingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Boudhanath",
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              PhosphorIcons.heartFill,
              color: Colors.red,
              size: 30.h,
            ))
      ],
    );
  }

  Widget rateReviewRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rateReviewDetails(
            iconData: PhosphorIcons.starFill,
            iconColor: Colors.yellow,
            text: "Rating",
            reviewRatingValue: 4.5,
            reviewNumber: 100),
        rateReviewDetails(
            iconData: PhosphorIcons.currencyDollar,
            iconColor: Colors.red,
            rate: 1000,
            text: "Estimated"),
        locationCard(),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget locationCard() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIcons.mapPinBold,
                color: Colors.redAccent,
              ),
              Text(
                  " ${context.watch<LocationService>().placemarks.last.locality} , ${context.watch<LocationService>().placemarks.last.country}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black, fontSize: 16.sp)),
            ],
          ),
        ));
  }

  Widget rateReviewDetails(
      {required IconData iconData,
      required Color iconColor,
      required String text,
      double? reviewRatingValue,
      double? rate,
      int? reviewNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
            ),
            reviewRatingValue != null
                ? Text(
                    "$reviewRatingValue , ($reviewNumber)",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                : Text(
                    "Nrs. $rate/-",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
          ],
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: MyColor.cyanColor),
        ),
      ],
    );
  }

  Widget descriptionText({required String description}) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class ImageSlider extends StatefulWidget {
  final int i;
  final List<String> imgList;
  const ImageSlider({super.key, required this.i, required this.imgList});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height.h / 2,
          width: MediaQuery.of(context).size.width.w,
          child: PageView.builder(
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: Image.asset(
                        widget.imgList[widget.i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ),
        ),
        Container(
          height: 120.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: Image.asset(
                          height: 92.h,
                          width: 90.w,
                          widget.imgList[widget.i],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 92.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: currentIndex == index
                              ? Colors.transparent
                              : Colors.black.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
