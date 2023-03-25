import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/widget/background.dart';

class SeeAllScreen extends StatefulWidget {
  final List<DataModel> dataModel;
  final String title;
  const SeeAllScreen({super.key, required this.dataModel, required this.title});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return customBackground(
        child: Scaffold(
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
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.dataModel.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Cards(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300.h,
                                        dataModel: widget.dataModel[index]));
                              })))
                    ]))));
  }
}

class Cards extends StatelessWidget {
  Cards(
      {super.key,
      required this.width,
      required this.height,
      this.scrollDirection = Axis.vertical,
      required this.dataModel});
  double width;
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
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.sp),
            elevation: 4,
            child: SizedBox(
              height: height.h,
              width: width.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: dataModel.imageUrls!.isEmpty
                    ? Image.network(
                        "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png",
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
