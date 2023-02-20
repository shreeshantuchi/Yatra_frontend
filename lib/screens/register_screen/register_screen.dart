import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/form_style.dart';
import 'package:yatra/utils/routes.dart';
import 'package:yatra/widget/background.dart';
import 'package:yatra/widget/custom-button/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _password;
  @override
  Widget build(BuildContext context) {
    return customBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      }),
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: FormStyle.signUpStyle(
                          context: context, hintText: "example@gmail.com"),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      onSaved: (newValue) => _password = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 8) {
                          return "Password should be minimum of 8 characters";
                        }
                      },
                      style: Theme.of(context).textTheme.bodyText1,
                      obscureText: true,
                      decoration: FormStyle.signUpStyle(
                          context: context, hintText: "Enter your password"),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 8) {
                          return "Password should be minimum of 8 characters";
                        }
                        if (value != _password) {
                          return "Password doesnt match";
                        }
                      }),
                      style: Theme.of(context).textTheme.bodyText1,
                      obscureText: true,
                      decoration: FormStyle.signUpStyle(
                          context: context, hintText: "Retype your password"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.of(context).pop()),
                            child: Text(
                              "Already have an account? \nLogin",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: MyColor.whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                        radius: 30.sp,
                        text: "Sign Up",
                        textColor: MyColor.blackColor,
                        color: MyColor.whiteColor.withOpacity(0.5),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, MyRoutes.landRoute);
                          }
                        }),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
