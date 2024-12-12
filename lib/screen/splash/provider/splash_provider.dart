import 'package:flutter/cupertino.dart';
import 'package:task_manager/screen/home/home_screen.dart';

class SplashScreenProvider extends ChangeNotifier {
  SplashScreenProvider(BuildContext context) {
    _context = context;
  }

  BuildContext? _context;
  BuildContext? get context => _context;

  moveToHome() {
    Navigator.pushReplacementNamed(context!, HomeScreen.routeName);
  }
}