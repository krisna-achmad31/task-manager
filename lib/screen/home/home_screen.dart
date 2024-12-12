import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:task_manager/component/color_component.dart';
import 'package:task_manager/component/text_component.dart';
import 'package:task_manager/screen/add/add_screen.dart';
import 'package:task_manager/screen/home/provider/home_provider.dart';

import '../../model/add_model/add_model.dart';
import 'component/month_selector.dart';
import 'component/priority_dropdown.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home_page';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeProvider(context),
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          Map<DateTime, List<ToDo>> groupedToDos = {};
          for (var todo in homeProvider.todosCustom) {
            DateTime date = DateTime(todo.date.year, todo.date.month, todo.date.day);
            if (!groupedToDos.containsKey(date)) {
              groupedToDos[date] = [];
            }
            groupedToDos[date]!.add(todo);
          }
          print('groupedToDos => $groupedToDos');
          List<DateTime> dates = groupedToDos.keys.toList()..sort();
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Container(
                          height: 49,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      homeProvider.changeIsToday(true);
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: homeProvider.isToday! ? primaryColor500 : Colors.white,
                                        borderRadius: BorderRadius.circular(99),
                                        border: homeProvider.isToday! ? null : Border.all(color: primaryColor500),
                                        boxShadow: homeProvider.isToday!
                                            ? [
                                                BoxShadow(
                                                  color: primaryColor500.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 5),
                                                )
                                              ]
                                            : null,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Text(
                                          'Today',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: homeProvider.isToday! ? Colors.white : primaryColor500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      homeProvider.changeIsToday(false);
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: homeProvider.isToday! ? Colors.white : primaryColor500,
                                        borderRadius: BorderRadius.circular(99),
                                        border: homeProvider.isToday! ? Border.all(color: primaryColor500) : null,
                                        boxShadow: homeProvider.isToday!
                                            ? [
                                                BoxShadow(
                                                  color: primaryColor500.withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 5),
                                                )
                                              ]
                                            : null,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Text(
                                          'Calendar',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: homeProvider.isToday! ? primaryColor500 : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AddScreen.routeName).then(
                                    (value) async {
                                      if(homeProvider.isToday == true){
                                        await homeProvider.getToDo();
                                      } else {
                                        await homeProvider.getToDoCustom();
                                      }

                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(99),
                                    border: Border.all(color: primaryColor500),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Text(
                                      'Add Task',
                                      style: AppTextStyles.baseTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Visibility(
                          visible: homeProvider.isToday!,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${homeProvider.day!}',
                                        style: AppTextStyles.baseTextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${homeProvider.date!}',
                                        style: AppTextStyles.baseTextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${homeProvider.month!}',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 90,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 2,
                                  height: double.infinity,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Today',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Progress',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              value: homeProvider.allDone! / homeProvider.maxAllPriority!,
                                              backgroundColor: Colors.grey,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                            ),
                                            Text(
                                              '${homeProvider.percentageAllPriority!}%',
                                              style: AppTextStyles.baseTextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'High',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          homeProvider.resultLoadingData == ResultLoadingData.loading ? 'Loading' : '${homeProvider.highDone!}/${homeProvider.maxHighPriority}',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Medium',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          homeProvider.resultLoadingData == ResultLoadingData.loading ? 'Loading' : '${homeProvider.mediumDone!}/${homeProvider.maxMediumPriority}',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Low',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          homeProvider.resultLoadingData == ResultLoadingData.loading ? 'Loading' : '${homeProvider.lowDone!}/${homeProvider.maxLowPriority}',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // homeProvider.getTodayToDoProgress(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: homeProvider.isToday!,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Today\'s Task',
                                    style: AppTextStyles.baseTextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  PriorityDropdown(
                                    initialPriority: homeProvider.priority!,
                                    onPriorityChanged: (newPriority) {
                                      homeProvider.changePriority(newPriority);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            homeProvider.resultLoadingData == ResultLoadingData.loading
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Shimmer(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor50,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : homeProvider.todos.length == 0
                                    ? Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit_note_outlined, size: 150, color: primaryColor500),
                                            Text(
                                              'No Task in ${homeProvider.priority} Priority',
                                              style: AppTextStyles.baseTextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: ListView.builder(
                                          itemCount: homeProvider.todos.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor50,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (homeProvider.todos[index].isDone == false) {
                                                                homeProvider.changeStatus(index);
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: homeProvider.todos[index].isDone! ? primaryColor500 : Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 8),
                                                          Container(
                                                            width: 8,
                                                            height: 150,
                                                            child: VerticalDivider(
                                                              color: primaryColor500,
                                                              thickness: 2,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        homeProvider.todos[index].title,
                                                                        style: AppTextStyles.baseTextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Icon(Icons.more_horiz)
                                                                    ],
                                                                  ),
                                                                  SizedBox(height: 8),
                                                                  Text(
                                                                    homeProvider.todos[index].description,
                                                                    style: AppTextStyles.baseTextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w300,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                        decoration: BoxDecoration(
                                                                          color: homeProvider.todos[index].priority! == 'High'
                                                                              ? accentErrorColor
                                                                              : homeProvider.todos[index].priority! == 'Medium'
                                                                                  ? accentWarningColor
                                                                                  : accentInformationColor,
                                                                          borderRadius: BorderRadius.circular(99),
                                                                        ),
                                                                        child: Text(
                                                                          homeProvider.todos[index].priority!,
                                                                          style: AppTextStyles.baseTextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${homeProvider.todos[index].date.day}/${homeProvider.todos[index].date.month}/${homeProvider.todos[index].date.year}',
                                                                        style: AppTextStyles.baseTextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w300,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !homeProvider.isToday!,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            MonthSelector(),
                            homeProvider.resultLoadingDataCustom == ResultLoadingDataCustom.loading
                                ? Expanded(
                                    child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Shimmer(
                                              child: Container(
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  color: primaryColor50,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      );
                                    },
                                  ),)
                                : dates.length != 0 ? Expanded(
                                    child: ListView.builder(
                                      itemCount: dates.length,
                                      itemBuilder: (context, index) {
                                        DateTime date = dates[index];
                                        List<ToDo> todos = groupedToDos[date]!;
                                        return Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: primaryColor100,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            height: 182,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${homeProvider.changeToDay(dates[index])}',
                                                        style: AppTextStyles.baseTextStyle(
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w300,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${dates[index].day}',
                                                        style: AppTextStyles.baseTextStyle(
                                                          fontSize: 50,
                                                          fontWeight: FontWeight.w200,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${homeProvider.changeToMMM(date.month)}',
                                                          style: AppTextStyles.baseTextStyle(
                                                            fontSize: 60,
                                                            fontWeight: FontWeight.w200,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                      child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 2),
                                                      child: ListView.builder(
                                                        itemCount: groupedToDos[date]!.length,
                                                        itemBuilder: (context, index) {
                                                          return Column(
                                                            children: [
                                                              Container(
                                                                width: double.infinity,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                  color: primaryColor50,
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          if (todos[index].isDone == false) {
                                                                            print('index => $index');
                                                                            print('change');
                                                                            homeProvider.changeStatusCustom(index, date,todos[index].id!);
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                            color: todos[index].isDone! ? primaryColor500 : Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.check,
                                                                            color: Colors.white,
                                                                            size: 15,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        todos[index].title,
                                                                        style: AppTextStyles.baseTextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: todos[index].priority! == 'High'
                                                                              ? accentErrorColor
                                                                              : todos[index].priority! == 'Medium'
                                                                                  ? accentWarningColor
                                                                                  : accentInformationColor,
                                                                          borderRadius: BorderRadius.circular(99),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                          child: Text(
                                                                            todos[index].priority!,
                                                                            style: AppTextStyles.baseTextStyle(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 8),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ) : Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit_note_outlined, size: 150, color: primaryColor500),
                                        Text(
                                          'No Task in this month',
                                          style: AppTextStyles.baseTextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
