import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/route_generate.dart';
import 'package:task_manager/screen/splash/splash_screen.dart';
import 'package:task_manager/theme.dart';

import 'component/color_component.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor500,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData(context),
      onGenerateRoute: RouteGenerate.generateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}

