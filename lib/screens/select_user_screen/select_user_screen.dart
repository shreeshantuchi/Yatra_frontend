import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/utils/routes.dart';

import 'package:yatra/widget/background.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userButton(imgUrl: "assets/traveler.png", text: "Yatri"),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    userButton(imgUrl: "assets/tour-guide.png", text: "Guide"),
                    userButton(imgUrl: "assets/guru.png", text: "Expert")
                  ],
                )
              ]),
        ),
      ),
    );
  }

  Widget userButton({required String imgUrl, required String text}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.registerRoute);
      },
      child: Container(
        height: 180.h,
        width: 180.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 2.w)),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imgUrl,
                height: 100.h,
                width: 100.h,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 20.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
