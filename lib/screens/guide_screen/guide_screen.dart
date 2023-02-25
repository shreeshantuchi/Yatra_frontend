import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/widget/background.dart';
import 'package:yatra/widget/custom-button/custom_button.dart';

List<Map<String, dynamic>> guideData = [
  {
    "name": "Justin Biber",
    "rating": 4.5,
    "locality": "Suryabinayak",
    "city": "bhaktapur",
    "rate": 1000,
    "imgUrl":
        "https://w0.peakpx.com/wallpaper/409/163/HD-wallpaper-justin-bieber-belieber-beliebers.jpg",
  },
  {
    "name": "Hailey Biber",
    "rating": 4.9,
    "locality": "Kamalbinayak",
    "city": "bhaktapur",
    "rate": 2000,
    "imgUrl":
        "https://media1.popsugar-assets.com/files/thumbor/0GeHi66QYzS6BJ9SHa3qXFF2QBs/156x98:1949x1891/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2019/12/17/894/n/1922398/efe641975df93a41f173a2.73115422_/i/Hailey-Bieber.jpg"
  },
  {
    "name": "Kendal Jenner",
    "rating": 4.2,
    "locality": "Pulchowk",
    "city": "kathmandu",
    "rate": 3599,
    "imgUrl":
        "http://t1.gstatic.com/licensed-image?q=tbn:ANd9GcQ_4RpUE8kkQ3VwDQS-79MZ-qClWRRZdehGRVxdze5SwCnfQoh2no3PmjDmjQNIhpH0XQTXXUoiHUKqEEM"
  },
  {
    "name": "Dwyane Johnson",
    "rating": 5,
    "locality": "Suryabinayak",
    "city": "bhaktapur",
    "rate": 4999,
    "imgUrl":
        "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTYYTLgX6ZLrYwz-3c7iB3gVs87jIKnbbg3Ba-Gt8ykJF2uZgu4"
  },
  {
    "name": "Justin Biber",
    "rating": 4.5,
    "locality": "Suryabinayak",
    "city": "bhaktapur",
    "rate": 1000,
    "imgUrl":
        "https://w0.peakpx.com/wallpaper/409/163/HD-wallpaper-justin-bieber-belieber-beliebers.jpg",
  },
];

class GuidScreen extends StatelessWidget {
  const GuidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: customBackground(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: guideData.length,
                  itemBuilder: (context, index) {
                    return GuideCard(
                      guide: guideData[index],
                    );
                  })
            ]),
          ),
        ),
      ),
    );
  }
}

class GuideCard extends StatelessWidget {
  final Map<String, dynamic> guide;
  const GuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp)),
              child: Padding(
                padding: EdgeInsets.only(left: 70.w, top: 20.h, bottom: 20.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${guide["name"]}",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black54),
                      ),
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.starFill,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            guide["rating"].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black54),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.mapPinBold,
                            color: MyColor.redColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            guide["locality"] + " , " + guide["city"],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.moneyFill,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Nrs ${guide["rate"]} per tour",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              PhosphorIcons.envelopeFill,
                              color: MyColor.redColor,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            CustomButton(
                                height: 40,
                                horizontalPadding: 10,
                                radius: 20,
                                color: MyColor.redColor,
                                text: "Contact",
                                onTap: () {})
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 45.sp,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              guide["imgUrl"],
            ),
            radius: 40.sp,
          ),
        )
      ],
    );
  }
}
