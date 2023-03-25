import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/models/food_model.dart';
import 'package:yatra/repository/data_api.dart';
import 'package:yatra/screens/guide_screen/guide_screen.dart';
import 'package:yatra/screens/home_screen/home_screen.dart';
import 'package:yatra/screens/location_scree/location_screen.dart';
import 'package:yatra/screens/news_screen/news_screen.dart';
import 'package:yatra/screens/register_screen/register_screen.dart';
import 'package:yatra/screens/home_screen/all_tab_home_screen/all_tab-screen.dart';
import 'package:yatra/services/auth_services.dart';
import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<IconData> iconList = [Icons.home, Icons.feed, Icons.person];

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomeScreen(),
    const NewsScreen(),
    const GuidScreen(),
  ];

  @override
  void initState() {
    context.read<DataApi>().getFoodList(context);
    context.read<DataApi>().getDestinationList(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 120.h, right: 20.w),
              child: FloatingActionButton(
                heroTag: "bt12",
                backgroundColor: MyColor.redColor.withOpacity(0.7),
                child: Text(
                  "SOS",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onPressed: (() async {
                  await FlutterPhoneDirectCaller.callNumber("9869101424");
                }),
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButton: FutureBuilder(
        future: context.read<AuthProvider>().getProfile(),
        builder: ((context, snapshot) {
          if (snapshot.data != null) {
            String profileUrl = snapshot.data!.profileImage!;
            return FloatingActionButton(
                backgroundColor: MyColor.redColor,
                child: const Icon(PhosphorIcons.mapPinBold),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0.sp),
                          topRight: Radius.circular(20.0.sp),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return StreamBuilder(
                            initialData: context.read<ProviderMaps>().position,
                            stream: context
                                .read<ProviderMaps>()
                                .listenToLocationChange(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return CircularProgressIndicator();
                              } else {
                                context.read<ProviderMaps>().cleanpoint();
                                context.read<ProviderMaps>().addMarker(
                                    LatLng(snapshot.data!.latitude,
                                        snapshot.data!.longitude),
                                    profileUrl);

                                return Container(
                                  height: 800.h,
                                  child: LocationScreen(
                                      initialPosition: LatLng(
                                          snapshot.data!.latitude,
                                          snapshot.data!.longitude)),
                                );
                              }
                            });
                      });
                });
          }

          return const SizedBox();
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.black54,
        inactiveColor: Colors.white.withOpacity(0.5),
        activeColor: Colors.white,
        icons: iconList,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 0,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          });
        },
        //other params
      ),
    );
  }
}
