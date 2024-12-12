import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/component/color_component.dart';
import 'package:task_manager/component/text_component.dart';
import 'package:task_manager/screen/home/provider/home_provider.dart';

class MonthSelector extends StatefulWidget {
  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        // homeProvider.changeMonth(_currentDate.month);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              homeProvider.previousMonth!,
              style: AppTextStyles.baseTextStyle(
                color: primaryColor400,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 16),
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: homeProvider.previousMonthCustom,
            ),
            Text(
              homeProvider.currentMonth!,
              style: AppTextStyles.baseTextStyle(
                fontSize: 39,
                fontWeight: FontWeight.w400,
                color: primaryColor500,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: homeProvider.nextMonthCustom,
            ),
            SizedBox(width: 16),
            Text(
              homeProvider.nextMonth!,
              style: AppTextStyles.baseTextStyle(
                color: primaryColor400,
                fontSize: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}
