import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/add/add_screen.dart';
import 'package:task_manager/screen/error/error_page_screen.dart';
import 'package:task_manager/screen/home/home_screen.dart';
import 'package:task_manager/screen/splash/splash_screen.dart';

class RouteGenerate {
  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    final args = settings?.arguments;

    switch (settings?.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AddScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AddScreen());
      case ErrorPageScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ErrorPageScreen());
      default:
        return null;
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
      builder: (context) => const ErrorPageScreen(),
    );
  }
}
