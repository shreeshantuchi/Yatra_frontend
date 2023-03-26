import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel_shmmer.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/widget/background.dart';

class SeeAllScreen extends StatefulWidget {
  final List<DataModel> dataModel;
  final String title;
  const SeeAllScreen({
    super.key,
    required this.dataModel,
    required this.title,
  });

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return customBackground(
        child: widget.dataModel.isNotEmpty
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
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
                              .headline1!
                              .copyWith(color: Colors.white),
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
                body: HomeCarouselShimmer(
                  width: MediaQuery.of(context).size.width.w,
                  scrollDirection: Axis.vertical,
                ),
              ));
  }
}
