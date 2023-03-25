import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/repository/data_api.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel_shmmer.dart';
import 'package:yatra/screens/sell_allscreen/see_all_screen.dart';
import 'package:yatra/utils/colors.dart';

class HomeTab extends StatefulWidget {
  final List<String> imagePaths;
  final List<DataModel> dataModel;
  final List<DataModel> dataModelPopular;
  const HomeTab(
      {super.key,
      required this.imagePaths,
      required this.dataModel,
      required this.dataModelPopular});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataModel.isNotEmpty && widget.dataModelPopular.isNotEmpty) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular", style: Theme.of(context).textTheme.headline3),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SeeAllScreen(
                                  title: "Popular",
                                  dataModel: widget.dataModelPopular,
                                ))),
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
              HomeCarousel(
                imagePaths: "",
                dataModelList: widget.dataModelPopular,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Perfect for you",
                        style: Theme.of(context).textTheme.headline3),
                    GestureDetector(
                      onTap: () async {},
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAllScreen(
                                      title: "Perfect for You",
                                      dataModel: widget.dataModel,
                                    ))),
                        child: Text(
                          "See all",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: MyColor.greyColor, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              HomeCarousel(
                dataModelList: widget.dataModel,
                height: 233,
                imagePaths: "assets/1.jpeg",
                width: MediaQuery.of(context).size.width,
                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ),
      );
    } else {
      return ShimmerWidgets();
    }
  }
}

class ShimmerWidgets extends StatefulWidget {
  const ShimmerWidgets({super.key});

  @override
  State<ShimmerWidgets> createState() => _ShimmerWidgetsState();
}

class _ShimmerWidgetsState extends State<ShimmerWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular", style: Theme.of(context).textTheme.headline3),
                Text(
                  "See all",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: MyColor.greyColor, fontSize: 18.sp),
                ),
              ],
            ),
            const HomeCarouselShimmer(),
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Perfect for you",
                      style: Theme.of(context).textTheme.headline3),
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
            HomeCarouselShimmer(
              height: 233,
              width: MediaQuery.of(context).size.width,
              scrollDirection: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }
}
