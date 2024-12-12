import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/component/button_component.dart';
import 'package:task_manager/component/color_component.dart';
import 'package:task_manager/component/text_component.dart';
import 'package:task_manager/screen/splash/provider/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SplashScreenProvider(context),
      child: Consumer<SplashScreenProvider>(
        builder: (context, splashScreenProvider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Image.asset(
                  'assets/ic_splash.png',
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Text(
                    'Task Management & To Do List',
                    style: AppTextStyles.baseTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    "This productive tool is designed to help you better manage your task project-wise conveniently!",
                    style: AppTextStyles.baseTextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: textSecondaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    width: double.infinity,
                    child: BaseElevatedButton(
                      text: "Let's Start",
                      onPressed: () {
                        splashScreenProvider.moveToHome();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
