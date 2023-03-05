import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/constant.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/widget/background.dart';
import 'package:yatra/widget/custom-button/custom_button.dart';

class SelectPreferneceScreen extends StatefulWidget {
  const SelectPreferneceScreen({super.key});

  @override
  State<SelectPreferneceScreen> createState() => _SelectPreferneceScreenState();
}

class _SelectPreferneceScreenState extends State<SelectPreferneceScreen> {
  List<String> preferenceDestinationSelected = [];
  List<String> preferenceFoodSelected = [];
  List<String> preferenceActivitySelected = [];

  @override
  Widget build(BuildContext context) {
    return customBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Destinations",
                style: Theme.of(context).textTheme.headline3,
              ),
              PreferenceGrid(
                preferences: destinationPreference,
                preferencesList: preferenceDestinationSelected,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Food",
                style: Theme.of(context).textTheme.headline3,
              ),
              PreferenceGrid(
                preferences: foodPreference,
                preferencesList: preferenceFoodSelected,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Activities",
                style: Theme.of(context).textTheme.headline3,
              ),
              PreferenceGrid(
                preferences: activitiesPreference,
                preferencesList: preferenceActivitySelected,
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    radius: 40.sp,
                    horizontalPadding: 100,
                    text: "Set",
                    onTap: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    color: MyColor.redColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PreferenceGrid extends StatefulWidget {
  final List preferences;
  const PreferenceGrid(
      {super.key, required this.preferences, required this.preferencesList});
  final List preferencesList;

  @override
  State<PreferenceGrid> createState() => _PreferenceGridState();
}

class _PreferenceGridState extends State<PreferenceGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.preferences.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 6),
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0),
      itemBuilder: ((context, index) {
        print(widget.preferences[index]);
        return PreferenceButton(
          preferenceText: widget.preferences[index].toString(),
          preferencesListSelected: widget.preferencesList,
        );
      }),
    );
  }
}

class PreferenceButton extends StatefulWidget {
  final String preferenceText;
  final List preferencesListSelected;
  bool isSelected = false;
  PreferenceButton(
      {super.key,
      required this.preferenceText,
      required this.preferencesListSelected});

  @override
  State<PreferenceButton> createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  @override
  Widget build(BuildContext context) {
    print(widget.preferencesListSelected);
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
          widget.isSelected
              ? widget.preferencesListSelected.add(widget.preferenceText)
              : widget.preferencesListSelected.remove(widget.preferenceText);
        });
      },
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            color: widget.isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 2.w,
              color:
                  widget.isSelected ? Colors.transparent : MyColor.whiteColor,
            )),
        child: Center(
            child: Text(
          widget.preferenceText,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color:
                  widget.isSelected ? MyColor.blackColor : MyColor.whiteColor),
        )),
      ),
    );
  }
}
