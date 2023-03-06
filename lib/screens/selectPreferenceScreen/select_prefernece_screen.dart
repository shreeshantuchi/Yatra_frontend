import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatra/constant.dart';
import 'package:yatra/models/interest_model.dart';
import 'package:yatra/repository/interest_api.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';
import 'package:yatra/widget/background.dart';
import 'package:yatra/widget/custom-button/custom_button.dart';

class SelectPreferneceScreen extends StatefulWidget {
  List<int> interestSelected = [];
  final bool push;
  SelectPreferneceScreen(
      {super.key, required this.interestSelected, required this.push});

  @override
  State<SelectPreferneceScreen> createState() => _SelectPreferneceScreenState();
}

class _SelectPreferneceScreenState extends State<SelectPreferneceScreen> {
  InterestAPi interestAPi = InterestAPi();

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
              FutureBuilder(
                  future: interestAPi.getDestinationInterestList(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return PreferenceGrid(
                        preferences: snapshot.data!,
                        preferencesList: widget.interestSelected,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Food",
                style: Theme.of(context).textTheme.headline3,
              ),
              FutureBuilder(
                  future: interestAPi.getFoodInterestList(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return PreferenceGrid(
                        preferences: snapshot.data!,
                        preferencesList: widget.interestSelected,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Activities",
                style: Theme.of(context).textTheme.headline3,
              ),
              FutureBuilder(
                  future: interestAPi.getActivitiesInterestList(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return PreferenceGrid(
                        preferences: snapshot.data!,
                        preferencesList: widget.interestSelected,
                      );
                    } else
                      return CircularProgressIndicator();
                  }),
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
                    onTap: () async {
                      await interestAPi.updateInterest(
                          interestList: widget.interestSelected);
                      widget.push
                          ? Navigator.pushReplacementNamed(
                              context, MyRoutes.tabRoute)
                          : Navigator.pop(context);
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
  final List<InterestModel> preferences;
  const PreferenceGrid(
      {super.key, required this.preferences, required this.preferencesList});
  final List<int> preferencesList;

  @override
  State<PreferenceGrid> createState() => _PreferenceGridState();
}

class _PreferenceGridState extends State<PreferenceGrid> {
  InterestAPi interestAPi = InterestAPi();
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
        return FutureBuilder(
            future: interestAPi.getYatriInterestList(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return PreferenceButton(
                  preference: widget.preferences[index],
                  preferencesListSelected: widget.preferencesList,
                  isSelected:
                      snapshot.data!.contains(widget.preferences[index].id),
                );
              } else
                return SizedBox();
            });
      }),
    );
  }
}

class PreferenceButton extends StatefulWidget {
  final InterestModel preference;
  final List<int> preferencesListSelected;
  bool isSelected;
  PreferenceButton(
      {super.key,
      required this.isSelected,
      required this.preference,
      required this.preferencesListSelected});

  @override
  State<PreferenceButton> createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isSelected
            ? widget.preferencesListSelected.remove(widget.preference.id!)
            : widget.preferencesListSelected.add(widget.preference.id!);
        setState(() {
          widget.isSelected = !widget.isSelected;
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
          widget.preference.name!,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color:
                  widget.isSelected ? MyColor.blackColor : MyColor.whiteColor),
        )),
      ),
    );
  }
}
