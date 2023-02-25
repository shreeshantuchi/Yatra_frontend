import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/models/user_model.dart';

import 'package:yatra/services/auth_services.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: context.watch<AuthProvider>().getProfile(),
                  builder: ((context, snapshot) {
                    if (snapshot.data != null) {
                      return userDetails(snapshot.data!);
                    }
                    return const SizedBox();
                  })),
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

  Widget userDetails(UserProfile userProfile) {
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
        profileImage(imgUrl: userProfile.profileImage!),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "${userProfile.firstName}  ${userProfile.lastName}",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: MyColor.blackColor),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "${userProfile.email}",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: MyColor.greyColor),
        ),
      ],
    );
  }

  Widget profileImage({required String imgUrl}) {
    return Container(
      height: 120.h,
      width: 120.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.sp),
          border: Border.all(
              color: MyColor.redColor.withOpacity(0.3), width: 4.sp)),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: CircleAvatar(
          radius: 60.sp,
          backgroundImage: NetworkImage(imgUrl),
        ),
      ),
    );
  }

  Widget ListTiles() {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.pencilSimpleLineBold),
          title: const Text("Edit Profile"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.lockBold),
          title: const Text("Change Password"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.mapPinLineBold),
          title: const Text("Change Location"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
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
