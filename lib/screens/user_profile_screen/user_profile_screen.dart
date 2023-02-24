import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/models/user_model.dart';
import 'package:yatra/screens/home_screen/home_screen.dart';
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
    final UserProfile userProfile =
        ModalRoute.of(context)?.settings.arguments as UserProfile;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              profileImage(
                  imgUrl:
                      "https://w0.peakpx.com/wallpaper/409/163/HD-wallpaper-justin-bieber-belieber-beliebers.jpg"),
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
                "example@gmail.com",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: MyColor.greyColor),
              ),
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
          title: Text("Edit Profile"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.lockBold),
          title: Text("Change Password"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.mapPinLineBold),
          title: Text("Change Location"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: customIcon(iconData: PhosphorIcons.infoBold),
          title: Text("App Information"),
          trailing: Icon(Icons.arrow_forward_ios),
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
          title: Text("Log Out"),
          trailing: Icon(Icons.arrow_forward_ios),
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
