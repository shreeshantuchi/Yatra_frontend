import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yatra/screens/tab_screen/tab-screen.dart';

import 'package:yatra/services/auth_services.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/form_style.dart';
import 'package:yatra/utils/routes.dart';

import 'package:yatra/widget/background.dart';
import 'package:yatra/widget/custom-button/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return customBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 66.h, bottom: 100.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            height: 95.h,
                            width: 235.5.h,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Your Email Address",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: MyColor.whiteColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: MyColor.whiteColor),
                      decoration: FormStyle.signUpStyle(
                          context: context, hintText: "example@gmail.com"),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Your Password",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: MyColor.whiteColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: MyColor.whiteColor),
                      obscureText: true,
                      decoration: FormStyle.signUpStyle(
                          context: context, hintText: "password"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (() => Navigator.pushNamed(
                              context, MyRoutes.selectUserRoute)),
                          child: Text(
                            "Don't have an account? \nRegister",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: MyColor.whiteColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: MyColor.whiteColor),
                          ),
                        )
                      ],
                    ),
                    CustomButton(
                        radius: 30.sp,
                        text: "Conitinue",
                        textColor: MyColor.blackColor,
                        color: MyColor.whiteColor.withOpacity(0.5),
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            var jwt = await context.read<AuthProvider>().login(
                                email: emailController.text,
                                password: passwordController.text);

                            if (jwt != null) {
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.tabRoute);
                            } else {}

                            // Form is valid, process data.
                          }
                        }),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.h,
                          width: 150.w,
                          color: MyColor.whiteColor.withOpacity(0.5),
                        ),
                        Text(" OR ",
                            style: Theme.of(context).textTheme.bodyText2),
                        Container(
                          height: 1.h,
                          width: 150.w,
                          color: MyColor.whiteColor.withOpacity(0.5),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                        imgIcon: "assets/google.png",
                        radius: 30.sp,
                        borderEnabled: true,
                        text: "Log in with Google",
                        textColor: MyColor.whiteColor,
                        color: Colors.transparent,
                        onTap: () async {
                          var jwt = await context.read<AuthProvider>().login(
                              email: emailController.text,
                              password: passwordController.text);

                          if (jwt != null) {
                            Navigator.pushNamed(context, MyRoutes.homeRoute);
                          } else {}
                        }),
                    SizedBox(
                      height: 48.h,
                    ),
                    CustomButton(
                        imgIcon: "assets/apple.png",
                        borderEnabled: true,
                        radius: 30.sp,
                        text: "Sign up with Apple",
                        textColor: MyColor.whiteColor,
                        color: Colors.transparent,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabScreen()))),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
