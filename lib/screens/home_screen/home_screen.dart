import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/models/user_model.dart';
import 'package:yatra/screens/home_screen/all_tab_home_screen/all_tab-screen.dart';

import 'package:yatra/services/auth_services.dart';

import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:yatra/widget/background.dart';

enum TabItem { home, news, profile }

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile userProfile = UserProfile();
  @override
  void initState() {
    // TODO: implement initState

    context.read<ProviderMaps>().listenToLocationChange();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<ProviderMaps>().placemarks.isNotEmpty
        ? customBackground(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 30.w, right: 30.w, top: 40.h),
                      child: Column(
                        children: [
                          welcomeHeadingText(context),
                          SizedBox(height: 20.h),
                          const SearchForm(),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    AllTab()
                  ],
                ),
              ),
            ),
          )
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }

  Widget welcomeHeadingText(BuildContext context) {
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
        FutureBuilder(
            future: context.read<AuthProvider>().getProfile(),
            builder: ((context, snapshot) {
              if (snapshot.data != null) {
                return Text(
                  "Namaste  \n${snapshot.data?.firstName}",
                  style: Theme.of(context).textTheme.headline3,
                );
              }
              return const SizedBox();
            })),
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
        GestureDetector(
          onTap: () async {},
          child: const Icon(
            PhosphorIcons.bellBold,
            color: MyColor.whiteColor,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, MyRoutes.userProfileRoute);
          },
          child: FutureBuilder(
              future: context.watch<AuthProvider>().getProfile(),
              builder: ((context, snapshot) {
                if (snapshot.data != null) {
                  return CircleAvatar(
                    radius: 40.sp,
                    backgroundImage: snapshot.data!.profileImage != null
                        ? NetworkImage(snapshot.data!.profileImage!)
                        : NetworkImage(
                            "https://thumbs.dreamstime.com/z/add-user-icon-vector-people-new-profile-person-illustration-business-group-symbol-male-195160356.jpg"),
                  );
                }
                return const SizedBox();
              })),
        )
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
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.withOpacity(0.1)),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 1.w, color: MyColor.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 2.w, color: MyColor.whiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.w,
              color: MyColor.whiteColor.withOpacity(0.5),
            ),
          ),
          suffixIcon: const Icon(
            PhosphorIcons.slidersHorizontalBold,
            color: MyColor.whiteColor,
          ),
          prefixIcon: const Icon(
            PhosphorIcons.magnifyingGlassBold,
            color: MyColor.whiteColor,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.w),
          hintText: "Search",
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: MyColor.whiteColor.withOpacity(0.8)),
        ),
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
              "${context.watch<ProviderMaps>().placemarks.last.locality} , ${context.watch<ProviderMaps>().placemarks.last.country}",
              style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}
