import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/repository/data_api.dart';
import 'package:yatra/screens/home_screen/home_screen.dart';
import 'package:yatra/screens/home_screen/widget/home_tab_screen/home_tab_screen.dart';
import 'package:yatra/utils/colors.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  @override
  void initState() {}

  final List<String> menuItems = ["All", "Destination", "Food", "Activities"];
  List<String> destinationImagePaths = [
    "assets/1.jpeg",
    "assets/2.jpeg",
    "assets/3.jpeg"
  ];
  List<String> foodImagePaths = [
    "assets/4.jpg",
    "assets/5.jpg",
    "assets/6.jpg"
  ];
  List<String> activityImagePaths = [
    "assets/7.jpg",
    "assets/8.jpg",
    "assets/9.jpg"
  ];
  final PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            height: 60,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentPageIndex = index;
                    });
                    pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      menuItems[index],
                      style: TextStyle(
                        color: currentPageIndex == index
                            ? MyColor.whiteColor
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height.h,
          width: MediaQuery.of(context).size.height.w / 0.1,
          child: PageView(
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            controller: pageController,
            children: [
              // FutureBuilder(
              //     future: context.read<DataApi>().getDestinationList(),
              //     builder: ((context, snapshot) {
              //       if (snapshot.data != null) {
              //         return HomeTab(
              //           dataModel: snapshot.data as List<DataModel>,
              //           imagePaths: foodImagePaths,
              //         );
              //       } else {
              //         return Center(
              //             child: SizedBox(
              //                 height: 40.h,
              //                 width: 40.h,
              //                 child: CircularProgressIndicator()));
              //       }
              //     })),
              // FutureBuilder(
              //     future: context.read<DataApi>().getDestinationList(),
              //     builder: ((context, snapshot) {
              //       if (snapshot.data != null) {
              //         return HomeTab(
              //           dataModel: snapshot.data as List<DataModel>,
              //           imagePaths: foodImagePaths,
              //         );
              //       } else {
              //         return Center(
              //             child: SizedBox(
              //                 height: 40.h,
              //                 width: 40.h,
              //                 child: CircularProgressIndicator()));
              //       }
              //     })),
              HomeTab(
                imagePaths: foodImagePaths,
                dataModel: context.watch<DataApi>().destinationList,
                dataModelPopular:
                    context.watch<DataApi>().destinationListPopular,
              ),
              HomeTab(
                  imagePaths: foodImagePaths,
                  dataModel: context.watch<DataApi>().destinationList,
                  dataModelPopular:
                      context.watch<DataApi>().destinationListPopular),

              HomeTab(
                  imagePaths: foodImagePaths,
                  dataModel: context.watch<DataApi>().foodList,
                  dataModelPopular: context.watch<DataApi>().foodList),
            ],
          ),
        ),
      ],
    );
  }
}
