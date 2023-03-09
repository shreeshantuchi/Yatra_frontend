import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/models/food_model.dart';

import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';

class HomeCarousel extends StatefulWidget {
  final String imagePaths;
  final double width;
  final double height;
  final List<DataModel> dataModelList;
  const HomeCarousel(
      {super.key,
      required this.imagePaths,
      this.width = 160,
      this.scrollDirection = Axis.horizontal,
      this.height = 215,
      required this.dataModelList});
  final Axis scrollDirection;

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
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
          itemCount: widget.dataModelList.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                int arguments = index;
                Navigator.pushNamed(context, MyRoutes.detailedDescriptionRoute,
                    arguments: widget.dataModelList[index]);
              },
              child: Cards(
                dataModel: widget.dataModelList[index],
                scrollDirection: widget.scrollDirection,
                height: widget.height,
                imagePath: widget.imagePaths,
                width: widget.width,
              ),
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
      required this.scrollDirection,
      required this.dataModel});
  final String imagePath;
  final double width;
  final double height;
  final Axis scrollDirection;
  final DataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20.sp),
            elevation: 4,
            child: SizedBox(
              height: height.h,
              width: width.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: dataModel.imageUrls!.isEmpty
                    ? Image.asset(
                        "assets/1.jpeg",
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        dataModel.imageUrls![0]["image"],
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
                stops: const [0.1, 0.5, 1.0],
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
                SizedBox(
                  width: scrollDirection != Axis.vertical ? 130.w : 290.w,
                  child: Text(
                    dataModel.name!,
                    overflow: TextOverflow.ellipsis,
                    style: scrollDirection != Axis.vertical
                        ? Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: MyColor.whiteColor, fontSize: 15.sp)
                        : Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: MyColor.whiteColor, fontSize: 18.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      PhosphorIcons.mapPinFill,
                      color: MyColor.cyanColor,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      width: scrollDirection != Axis.vertical ? 100.w : 250.w,
                      child: Text(
                        dataModel.location!,
                        overflow: TextOverflow.ellipsis,
                        style: scrollDirection != Axis.vertical
                            ? Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: MyColor.cyanColor, fontSize: 12.sp)
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: MyColor.cyanColor, fontSize: 15.sp),
                      ),
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
