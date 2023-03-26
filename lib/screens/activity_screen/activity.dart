import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:yatra/models/activity_model.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel_shmmer.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/widget/background.dart';

class ActivityScreen extends StatefulWidget {
  final List<DataModel> dataModel;
  final String title;
  const ActivityScreen({
    super.key,
    required this.dataModel,
    required this.title,
  });

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.dataModel.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.80,
                      child: HomeCarousel(
                        imagePaths: " ",
                        dataModelList: widget.dataModel,
                        scrollDirection: Axis.vertical,
                        width: MediaQuery.of(context).size.width.w,
                        itemCount: widget.dataModel.length,
                      ),
                    )
                  ]),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: HomeCarouselShimmer(
              width: MediaQuery.of(context).size.width.w,
              scrollDirection: Axis.vertical,
            ));
  }
}
