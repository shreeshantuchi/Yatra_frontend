import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yatra/models/user_model.dart';
import 'package:yatra/services/auth_services.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/form_style.dart';
import 'package:yatra/utils/routes.dart';
import 'package:yatra/widget/background.dart';
import 'package:yatra/widget/custom-button/custom_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserProfile? userProfile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  // Pick an image

  Country _selctedCountry = Country(
      phoneCode: "977",
      countryCode: "NP",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Nepal",
      example: "9841234567",
      displayName: "Nepal (NP) [+977]",
      displayNameNoCountryCode: "Nepal (NP)",
      e164Key: "977-NP-0");
  @override
  Widget build(BuildContext context) {
    bool push = ModalRoute.of(context)!.settings.arguments as bool;
    getUser(context);

    return customBackground(
        child: SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Set Profile",
                        style: Theme.of(context).textTheme.headline3),
                    SizedBox(
                      height: 80.h,
                    ),
                    FutureBuilder(
                        future: context.watch<AuthProvider>().getProfile(),
                        builder: ((context, snapshot) {
                          if (snapshot.data != null) {
                            return Container(
                              height: 120.h,
                              width: 120.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70.sp),
                                  border: Border.all(
                                      color:
                                          MyColor.whiteColor.withOpacity(0.3),
                                      width: 4.sp)),
                              child: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: GestureDetector(
                                  onTap: () async {
                                    image = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                      radius: 60.sp,
                                      backgroundImage: image != null
                                          ? FileImage(File(image!.path))
                                              as ImageProvider
                                          : snapshot.data!.profileImage != null
                                              ? NetworkImage(
                                                  snapshot.data!.profileImage!)
                                              : const NetworkImage(
                                                  "https://thumbs.dreamstime.com/z/add-user-icon-vector-people-new-profile-person-illustration-business-group-symbol-male-195160356.jpg")),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        })),
                    SizedBox(
                      height: 20.h,
                    ),
                    nameRow(),
                    SizedBox(
                      height: 20.h,
                    ),
                    selectCountryAndPhoneNumber(),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                        radius: 20,
                        color: MyColor.redColor,
                        text: "Done",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await context
                                .read<AuthProvider>()
                                .updateUserProfile(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    country: _selctedCountry.name,
                                    phoneNumber: _phoneNumberController.text,
                                    imageFile: File(image!.path));
                            push
                                ? Navigator.pushReplacementNamed(
                                    context, MyRoutes.tabRoute)
                                : Navigator.pop(context);
                          }
                        }),
                  ]),
            ),
          ),
        ),
      ),
    ));
  }

  void getUser(BuildContext context) async {
    userProfile = await context.read<AuthProvider>().getProfile();
    if (userProfile!.firstName != null) {
      _firstNameController.text = userProfile!.firstName!;
      _lastNameController.text = userProfile!.lastName!;
      _phoneNumberController.text = userProfile!.phoneNumber!;
    }
  }

// /Text("+${_selctedCountry.phoneCode}")
  Widget selectCountryAndPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone Number", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Phone Number cannot \nbe empty";
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: MyColor.whiteColor),
              decoration: FormStyle.signUpStyle(
                  context: context, hintText: "Enter your Phone Number"),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Country", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                  exclude: <String>['KN', 'MF'],
                  favorite: <String>['SE'],
                  //Optional. Shows phone code before the country name.
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    // _selctedCountry = country;
                    setState(() {
                      _selctedCountry = country;
                    });
                  },
                  // Optional. Sets the theme for the country list picker.
                  countryListTheme: CountryListThemeData(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: MyColor.blackColor),
                      // Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      // Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                      // Optional. Styles the text in the search field
                      searchTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: MyColor.blackColor)),
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColor.whiteColor,
                      width: 2.sp,
                    ),
                    borderRadius: BorderRadius.circular(40.sp),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    child: Text(
                      "${_selctedCountry.flagEmoji}  ${_selctedCountry.name}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget nameRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First Name", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: _firstNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "First Name cannot \nbe empty";
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: MyColor.whiteColor),
              decoration: FormStyle.signUpStyle(
                  context: context, hintText: "Enter your First Name "),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Last Name", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: _lastNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Last Name cannot \nbe empty";
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: MyColor.whiteColor),
              decoration: FormStyle.signUpStyle(
                  context: context, hintText: "Enter your last name"),
            ),
          ],
        ),
      ],
    );
  }
}
