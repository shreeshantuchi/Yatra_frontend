import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/screens/location_scree/location_screen.dart';
import 'package:yatra/services/auth_services.dart';

import 'package:yatra/utils/colors.dart';

import 'package:yatra/widget/background.dart';

class DetailDscriptionScreen extends StatefulWidget {
  const DetailDscriptionScreen({
    super.key,
  });

  @override
  State<DetailDscriptionScreen> createState() => _DetailDscriptionScreenState();
}

class _DetailDscriptionScreenState extends State<DetailDscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    DataModel dataModel =
        ModalRoute.of(context)!.settings.arguments as DataModel;
    int index = dataModel.imageUrls!.length;
    List? imgList = dataModel.imageUrls;

    return customBackground(
      child: Scaffold(
          floatingActionButton: dataModel.phoneNumber != null
              ? FloatingActionButton(
                  onPressed: () async {
                    String number = dataModel.phoneNumber!
                        .substring(0, dataModel.phoneNumber!.length - 1);
                    if (number[0] == "1") {
                      number = "0$number";
                    }
                    Uri launchUri = Uri(
                      scheme: 'tel',
                      path: number,
                    );
                    launchUrl(launchUri);
                  },
                  backgroundColor: MyColor.redColor.withOpacity(0.8),
                  child: Icon(
                    PhosphorIcons.phoneCallBold,
                    color: Colors.white,
                  ),
                )
              : null,
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Column(
            children: [
              ImageSlider(
                i: index,
                imgList: imgList,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    headingRow(dataModel),
                    SizedBox(
                      height: 10.h,
                    ),
                    rateReviewRow(dataModel),
                    SizedBox(
                      height: 30.h,
                    ),
                    descriptionText(
                        description: dataModel.description.toString()),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget headingRow(DataModel dataModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 300.w,
          child: Text(
            dataModel.name!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              PhosphorIcons.heartFill,
              color: Colors.red,
              size: 30.h,
            ))
      ],
    );
  }

  Widget rateReviewRow(DataModel dataModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rateReviewDetails(
            iconData: PhosphorIcons.starFill,
            iconColor: Colors.yellow,
            text: "Rating",
            reviewRatingValue: 5,
            reviewNumber: 100),
        rateReviewDetails(
            iconData: PhosphorIcons.currencyDollar,
            iconColor: Colors.red,
            rate: double.parse(dataModel.averagePrice!),
            text: "Estimated"),
        FutureBuilder(
          future: context.read<AuthProvider>().getProfile(),
          builder: ((context, snapshot) {
            if (snapshot.data != null) {
              return locationCard(
                dataModel: dataModel,
                profileUrl: snapshot.data!.profileImage == null
                    ? "https://thumbs.dreamstime.com/z/add-user-icon-vector-people-new-profile-person-illustration-business-group-symbol-male-195160356.jpg"
                    : snapshot.data!.profileImage!,
                destinationUrl: dataModel.imageUrls!.isEmpty
                    ? "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png"
                    : dataModel.imageUrls?[0]["image"],
              );
            }

            return const SizedBox();
          }),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget locationCard(
      {required String profileUrl,
      required String destinationUrl,
      required DataModel dataModel}) {
    String originalString = dataModel.location!;
    List<String> words = originalString.split(",");
    String newlocationString = words.join("\n");

    return GestureDetector(
      onTap: () async {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0.sp),
                topRight: Radius.circular(20.0.sp),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return StreamBuilder(
                  initialData: context.read<ProviderMaps>().position,
                  stream: context.read<ProviderMaps>().listenToLocationChange(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    } else {
                      context.read<ProviderMaps>().cleanpoint();
                      context.read<ProviderMaps>().addMarker(
                          LatLng(snapshot.data!.latitude,
                              snapshot.data!.longitude),
                          profileUrl);
                      context.read<ProviderMaps>().addMarker(
                          LatLng(double.parse(dataModel.latitude!),
                              double.parse(dataModel.longitude!)),
                          destinationUrl);
                      context.read<ProviderMaps>().routermap();
                      return Container(
                        height: 600.h,
                        child: LocationScreen(
                            initialPosition: LatLng(snapshot.data!.latitude,
                                snapshot.data!.longitude)),
                      );
                    }
                  });
            });
      },
      child: Container(
          width: 180.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIcons.mapPinBold,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    newlocationString,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black, fontSize: 16.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget rateReviewDetails(
      {required IconData iconData,
      required Color iconColor,
      required String text,
      double? reviewRatingValue,
      double? rate,
      int? reviewNumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
            ),
            reviewRatingValue != null
                ? Text(
                    "$reviewRatingValue , ($reviewNumber)",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                : Text(
                    "Nrs. $rate/-",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
          ],
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: MyColor.cyanColor),
        ),
      ],
    );
  }

  Widget descriptionText({required String description}) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class ImageSlider extends StatefulWidget {
  final int i;
  final List? imgList;
  const ImageSlider({super.key, required this.i, required this.imgList});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height.h / 2.3,
          width: MediaQuery.of(context).size.width.w,
          child: PageView.builder(
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.i == 0 ? 1 : widget.i,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: Image.network(
                        widget.imgList!.isEmpty
                            ? "https://alphapartners.lv/wp-content/themes/consultix/images/no-image-found-360x260.png"
                            : widget.imgList![index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ),
        ),
        Container(
          height: 120.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.imgList!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: Image.network(
                          widget.imgList![index]["image"],
                          height: 92.h,
                          width: 90.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 92.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: currentIndex == index
                              ? Colors.transparent
                              : Colors.black.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
