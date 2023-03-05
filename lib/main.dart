import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:yatra/constant.dart';
import 'package:yatra/location/location_provider.dart';
import 'package:yatra/screens/detail_description_screen/detail_description_screen.dart';
import 'package:yatra/screens/home_screen/home_screen.dart';
import 'package:yatra/screens/landing_screen/landing_screen.dart';
import 'package:yatra/screens/location_scree/location_screen.dart';
import 'package:yatra/screens/login_screen/login_screen.dart';
import 'package:yatra/screens/splash_screen/splash_screen.dart';
import 'package:yatra/screens/tab_screen/tab-screen.dart';
import 'package:yatra/screens/update_details_screen/update_details_screen.dart';
import 'package:yatra/screens/user_profile_screen/user_profile_screen.dart';
import 'package:yatra/services/auth_services.dart';

import 'package:yatra/utils/colors.dart';
import 'package:yatra/utils/routes.dart';
import 'package:yatra/utils/style.dart';

import 'screens/register_screen/register_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProviderMaps()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Yatra',
            theme: ThemeData(
                scaffoldBackgroundColor: MyColor.backgroundColor,
                appBarTheme: const AppBarTheme(
                    backgroundColor: MyColor.backgroundColor,
                    elevation: 0,
                    iconTheme: IconThemeData(color: MyColor.greyColor)),
                textTheme: Styles.data,
                backgroundColor: MyColor.backgroundColor),
            themeMode: ThemeMode.light,
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.dark,
            ),
            initialRoute: "/",
            // routes: {
            //   MyRoutes.splashScreenRoute: (context) => const SplashScreen(),
            //   MyRoutes.landRoute: ((context) => const LandingScreen()),
            //   MyRoutes.loginRoute: (context) => const LoginScreen(),
            //   MyRoutes.homeRoute: ((context) => HomeScreen()),
            //   MyRoutes.locationRoute: ((context) => LocationScreen()),
            //   MyRoutes.registerRoute: ((context) => const RegisterScreen()),
            // },

            onGenerateRoute: (settings) {
              switch (settings.name) {
                case MyRoutes.splashScreenRoute:
                  return PageTransition(
                    child: const SplashScreen(),
                    type: PageTransitionType.rightToLeftWithFade,
                    settings: settings,
                    duration: const Duration(seconds: smallDuration),
                  );

                case MyRoutes.landRoute:
                  return PageTransition(
                    child: const LandingScreen(),
                    type: PageTransitionType.rightToLeftWithFade,
                    settings: settings,
                    duration: const Duration(seconds: smallDuration),
                  );

                case MyRoutes.loginRoute:
                  return PageTransition(
                    child: const LoginScreen(),
                    type: PageTransitionType.rightToLeftWithFade,
                    settings: settings,
                    duration: const Duration(seconds: smallDuration),
                  );

                case MyRoutes.homeRoute:
                  return PageTransition(
                    child: HomeScreen(),
                    type: PageTransitionType.rightToLeftWithFade,
                    settings: settings,
                    duration: const Duration(seconds: smallDuration),
                  );

                case MyRoutes.registerRoute:
                  return PageTransition(
                      child: const RegisterScreen(),
                      type: PageTransitionType.rightToLeftWithFade,
                      settings: settings,
                      duration: const Duration(seconds: smallDuration));
                case MyRoutes.tabRoute:
                  return PageTransition(
                      child: const TabScreen(),
                      type: PageTransitionType.rightToLeftWithFade,
                      settings: settings,
                      duration: const Duration(seconds: smallDuration));
                case MyRoutes.userProfileRoute:
                  return PageTransition(
                      child: UserProfileScreen(),
                      type: PageTransitionType.leftToRightWithFade,
                      settings: settings,
                      duration: const Duration(seconds: smallDuration));
                case MyRoutes.detailedDescriptionRoute:
                  return PageTransition(
                      child: DetailDscriptionScreen(),
                      type: PageTransitionType.leftToRightWithFade,
                      settings: settings,
                      duration: const Duration(seconds: smallDuration));
                case MyRoutes.updateProfileRoute:
                  return PageTransition(
                      child: UpdateProfileScreen(),
                      type: PageTransitionType.leftToRightWithFade,
                      settings: settings,
                      duration: const Duration(seconds: smallDuration));

                default:
                  return null;
              }
            },
          );
        });
  }
}
