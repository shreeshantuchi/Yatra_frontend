import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatra/repository/news_api.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/widget/background.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return customBackground(
        child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "News",
                style: Theme.of(context).textTheme.headline1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: FutureBuilder(
                  future: context.read<NewsApi>().getNewsList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 12,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: newsCard(
                                  topic: snapshot.data![index].topic!,
                                  sourceName: snapshot.data![index].sourceName!,
                                  date: snapshot.data![index].date!,
                                  imgUrl: snapshot.data![index].imgUrl == null
                                      ? "https://t3.ftcdn.net/jpg/04/42/47/52/240_F_442475292_5ouemiiJiArGyNKSWgUpkRR8lmep6jgM.jpg"
                                      : snapshot.data![index].imgUrl!,
                                  sourceUrl: snapshot.data![index].sourceLink!),
                            );
                          }));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget newsCard(
      {required String topic,
      required String sourceName,
      required String date,
      required String imgUrl,
      required String sourceUrl}) {
    return Stack(
      children: [
        SizedBox(
          height: 170.h,
          width: MediaQuery.of(context).size.width.w,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.sp),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              )),
        ),
        Container(
          height: 170.h,
          width: MediaQuery.of(context).size.width.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.black.withOpacity(0.5)),
        ),
        GestureDetector(
          onTap: () async {
            Uri url = Uri.parse(sourceUrl);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: Colors.transparent),
              height: 170.h,
              width: MediaQuery.of(context).size.width.w,
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      topic,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 100.w,
                            height: 30.h,
                            child: Text(
                              sourceName,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                        Text(
                          date,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
