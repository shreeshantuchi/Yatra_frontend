import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:yatra/repository/api.dart';
import 'package:yatra/screens/home_screen/widget/home_carousel.dart';
import 'package:yatra/services/auth_services.dart';
import 'package:yatra/services/location_services.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';
import 'package:provider/provider.dart';

enum TabItem { home, news, profile }

class HomeScreen extends StatefulWidget {
  List<String> imagePaths = ["assets/1.jpeg", "assets/2.jpeg", "assets/3.jpeg"];
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Api api = Api();
  @override
  void initState() {
    // TODO: implement initState
    context.read<LocationService>().determinePosition();
    context.read<LocationService>().listenToLocationChange();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<LocationService>().placemarks.isNotEmpty
        ? Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const WelcomeHeadingText(),
                    SizedBox(height: 20.h),
                    const SearchForm(),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: MyColor.blackColor),
                          ),
                          Text(
                            "See all",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: MyColor.greyColor, fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                    HomeCarousel(imagePaths: widget.imagePaths),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Perfect for you",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: MyColor.blackColor),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String? jwtToken = await context
                                  .read<AuthProvider>()
                                  .storage
                                  .read(key: "jwt");

                              api.getProfile(context
                                  .read<AuthProvider>()
                                  .getUserId(jwtToken));
                            },
                            child: Text(
                              "See all",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: MyColor.greyColor,
                                      fontSize: 18.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeCarousel(
                      height: 300,
                      imagePaths: widget.imagePaths,
                      width: MediaQuery.of(context).size.width,
                      scrollDirection: Axis.vertical,
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}

class WelcomeHeadingText extends StatelessWidget {
  final String user;
  const WelcomeHeadingText({super.key, this.user = "Nancy"});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            welcomeText(context),
            SizedBox(
              height: 5.h,
            ),
            const CurrentLcoation()
          ],
        ),
        menuIcons(context),
      ],
    );
  }

  Widget welcomeText(BuildContext context) {
    return Row(
      children: [
        Text(
          "Welcome, $user ",
          style: Theme.of(context).textTheme.headline6,
        ),
        const Icon(
          PhosphorIcons.handWavingFill,
          color: Colors.amber,
        ),
      ],
    );
  }

  Widget menuIcons(BuildContext context) {
    return Row(
      children: [
        const Icon(PhosphorIcons.bellBold),
        SizedBox(
          width: 20.w,
        ),
        GestureDetector(
            onTap: () async {
              await context
                  .read<AuthProvider>()
                  .storage
                  .write(key: "jwt", value: null);

              if (await context.read<AuthProvider>().storage.read(key: "jwt") ==
                  null) {
                Navigator.pushNamedAndRemoveUntil(
                    context, MyRoutes.landRoute, (route) => false);
              }
            },
            child: const Icon(PhosphorIcons.dotsThreeOutlineVerticalBold))
      ],
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.withOpacity(0.1)),
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: const Icon(PhosphorIcons.slidersHorizontalBold),
            prefixIcon: const Icon(PhosphorIcons.magnifyingGlassBold),
            contentPadding: EdgeInsets.symmetric(vertical: 10.w),
            hintText: "Search",
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: MyColor.blackColor),
            border: InputBorder.none),
      ),
    );
  }
}

class CurrentLcoation extends StatefulWidget {
  const CurrentLcoation({super.key});

  @override
  State<CurrentLcoation> createState() => _CurrentLcoationState();
}

class _CurrentLcoationState extends State<CurrentLcoation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MyRoutes.locationRoute),
      child: Row(
        children: [
          const Icon(
            PhosphorIcons.mapPinBold,
            color: MyColor.greyColor,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "${context.watch<LocationService>().placemarks.last.locality} , ${context.watch<LocationService>().placemarks.last.country}",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: MyColor.blackColor),
          )
        ],
      ),
    );
  }
}
