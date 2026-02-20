import 'package:fintrix/auth/apptheme.dart';
import 'package:fintrix/auth/authentication.dart';
import 'package:fintrix/helper/platformUtils.dart';
import 'package:fintrix/screen/first_screen.dart';
import 'package:fintrix/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      // getPages: PlatformUtils.isAndroid ? RouteTable.pages : null,
      //  ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      // ),
      home: WelcomeScreen(),
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = 500;
            bool isWide = constraints.maxWidth > maxWidth;

            return Center(
              child: SizedBox(
                width: isWide ? maxWidth : double.infinity,
                child: child,
              ),
            );
          },
        );
      },
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
