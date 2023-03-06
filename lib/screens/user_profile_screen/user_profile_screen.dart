import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'package:yatra/repository/interest_api.dart';
import 'package:yatra/screens/selectPreferenceScreen/select_prefernece_screen.dart';

import 'package:yatra/services/auth_services.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userDetails(context),
              SizedBox(
                height: 50.h,
              ),
              ListTiles(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Profile",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: MyColor.blackColor),
            ),
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        profileImage(context),
        SizedBox(
          height: 20.h,
        ),
        FutureBuilder(
          future: context.watch<AuthProvider>().getProfile(),
          builder: ((context, snapshot) {
            if (snapshot.data != null) {
              print("world");
              return Text(
                "${snapshot.data?.firstName}  ${snapshot.data!.lastName}",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: MyColor.blackColor),
              );
            }
            return const SizedBox();
          }),
        ),
        SizedBox(
          height: 10.h,
        ),
        FutureBuilder(
            future: context.watch<AuthProvider>().getProfile(),
            builder: ((context, snapshot) {
              if (snapshot.data != null) {
                return Text(
                  snapshot.data!.email!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: MyColor.greyColor),
                );
              }
              return const SizedBox();
            })),
      ],
    );
  }

  Widget profileImage(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.sp),
          border: Border.all(
              color: MyColor.redColor.withOpacity(0.3), width: 4.sp)),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: FutureBuilder(
            future: context.watch<AuthProvider>().getProfile(),
            builder: ((context, snapshot) {
              if (snapshot.data != null) {
                return CircleAvatar(
                  radius: 60.sp,
                  backgroundImage: snapshot.data!.profileImage != null
                      ? NetworkImage(snapshot.data!.profileImage!)
                      : NetworkImage(
                          "https://thumbs.dreamstime.com/z/add-user-icon-vector-people-new-profile-person-illustration-business-group-symbol-male-195160356.jpg"),
                );
              }
              return const SizedBox();
            })),
      ),
    );
  }

  Widget ListTiles() {
    InterestAPi interestAPi = InterestAPi();
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.updateProfileRoute,
                arguments: false);
          },
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.pencilSimpleLineBold),
          title: const Text("Edit Profile"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          onTap: () async {},
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.lockBold),
          title: const Text("Change Password"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          onTap: () async {
            List<int> interest = [];
            interest = await interestAPi.getYatriInterestList();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SelectPreferneceScreen(
                          push: false,
                          interestSelected: interest,
                        ))));
          },
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.heartBold),
          title: const Text("Your Interests"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          onTap: () {
            InterestAPi interestAPi = InterestAPi();
            interestAPi.getYatriInterestList();
          },
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.infoBold),
          title: const Text("App Information"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
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
          contentPadding: EdgeInsets.zero,
          leading: customIcon(
              iconData: PhosphorIcons.signOutBold, color: MyColor.redColor),
          title: const Text("Log Out"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget customIcon(
      {Color color = MyColor.cyanColor, required IconData iconData}) {
    return Container(
      height: 50.h,
      width: 50.h,
      decoration:
          BoxDecoration(color: color.withOpacity(0.3), shape: BoxShape.circle),
      child: Icon(iconData),
    );
  }
}
