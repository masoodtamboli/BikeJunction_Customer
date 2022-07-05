import 'dart:async';

import 'package:bike_junction_customer/screens/Dashboard/DashboardPage.dart';
import 'package:bike_junction_customer/screens/LogIn/LogInScreen.dart';
import 'package:bike_junction_customer/utils/MyAssets.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(25, 53, 119, .1),
  100: Color.fromRGBO(25, 53, 119, .2),
  200: Color.fromRGBO(25, 53, 119, .3),
  300: Color.fromRGBO(25, 53, 119, .4),
  400: Color.fromRGBO(25, 53, 119, .5),
  500: Color.fromRGBO(25, 53, 119, .6),
  600: Color.fromRGBO(25, 53, 119, .7),
  700: Color.fromRGBO(25, 53, 119, .8),
  800: Color.fromRGBO(25, 53, 119, .9),
  900: Color.fromRGBO(25, 53, 119, 1),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BikeJunction Customer',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff0000ff, color),
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: MaterialColor(0xff0000ff, color)),
        ),
        home: Home(),
        // AddJobsScreen()
        //LogInScreen()
        // EnterOtpScreen("+919011547660")
        // DashboardScreen()
      );
    });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void startTimer() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SharedPreference.getIsLogin() == true
                          ? DashboardPage()
                          : LogInScreen()),
            ));
  }

  @override
  void initState() {
    super.initState();
    SharedPreference.init();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Center(
      child: Container(
          color: MyColors.app_theme_color,
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(MyAssets.app_logo)),
    );
  }
}
