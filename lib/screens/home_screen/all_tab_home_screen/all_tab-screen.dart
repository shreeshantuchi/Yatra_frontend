import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/screens/home_screen/home_screen.dart';
import 'package:yatra/screens/home_screen/widget/home_tab_screen/home_tab_screen.dart';
import 'package:yatra/utils/colors.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
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
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      menuItems[index],
                      style: TextStyle(
                        color: currentPageIndex == index
                            ? MyColor.blackColor
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
              HomeTab(
                imagePaths: destinationImagePaths,
              ),
              HomeTab(
                imagePaths: destinationImagePaths,
              ),
              HomeTab(
                imagePaths: foodImagePaths,
              ),
              HomeTab(
                imagePaths: activityImagePaths,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
