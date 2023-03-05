import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/screens/location_scree/location_screen.dart';
import 'package:yatra/services/auth_services.dart';

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
        FutureBuilder(
          future: context.read<AuthProvider>().getProfile(),
          builder: ((context, snapshot) {
            if (snapshot.data != null) {
              return locationCard(
                  profileUrl: snapshot.data!.profileImage!,
                  destinationUrl:
                      "data:image/jpeg;base64,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");
            }

            return const SizedBox();
          }),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget locationCard(
      {required String profileUrl, required String destinationUrl}) {
    return GestureDetector(
      onTap: () async {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0.sp),
                topRight: Radius.circular(20.0.sp),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return FutureBuilder(
                  future: context.read<ProviderMaps>().determinePosition(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    } else {
                      context.read<ProviderMaps>().addMarker(
                          LatLng(snapshot.data!.latitude,
                              snapshot.data!.longitude),
                          profileUrl);
                      context.read<ProviderMaps>().addMarker(
                          LatLng(27.67155, 85.42033), destinationUrl);
                      context.read<ProviderMaps>().routermap();
                      return Container(
                        height: 600.h,
                        child: LocationScreen(
                            initialPosition: LatLng(snapshot.data!.latitude,
                                snapshot.data!.longitude)),
                      );
                    }
                  });
            });
      },
      child: Container(
          width: 160.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIcons.mapPinBold,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    " ${context.watch<ProviderMaps>().placemarks.last.locality} , \n${context.watch<ProviderMaps>().placemarks.last.country}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black, fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
    );
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
