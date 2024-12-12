import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/component/color_component.dart';
import 'package:task_manager/component/text_component.dart';
import 'package:task_manager/screen/add/provider/add_provider.dart';

import '../../model/add_model/add_model.dart';

class AddScreen extends StatefulWidget {
  static const String routeName = '/add';

  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AddProvider(context),
      child: Consumer<AddProvider>(
        builder: (context, addProvider, child) {
          return SafeArea(
            child: Form(
              key: addProvider.formKey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Add Task', style: AppTextStyles.baseTextStyle(
                    color: primaryColor500,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: primaryColor500),
                    onPressed: () {
                      Navigator.pop(context);
                    },)
                ),
                body: ListView(
                  primary: true,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Priority',
                          style: AppTextStyles.baseTextStyle(
                            color: primaryColor500,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor500.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButtonFormField<String>(
                              value: addProvider.priority,
                              onChanged: (String? newValue) {
                                addProvider.changePriority(newValue!);
                              },
                              items: <String>['High', 'Medium', 'Low']
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Tittle',
                          style: AppTextStyles.baseTextStyle(
                            color: primaryColor500,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Input your tittle task',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            fillColor: primaryColor500.withOpacity(0.2),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            filled: true,

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            addProvider.changeTitle(value);
                            if (addProvider.title!.contains('today')) {
                              addProvider.changeDate(DateTime.now());
                            }
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Description',
                          style: AppTextStyles.baseTextStyle(
                            color: primaryColor500,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Input your description task',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            counterText: '',
                            filled: true,
                            fillColor: primaryColor500.withOpacity(0.2),
                          ),
                          maxLines: 3,
                          maxLength: 40,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            if(value.length == 40){
                              return 'Description must be less than 50 characters';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            addProvider.changeDescription(value);
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Date',
                          style: AppTextStyles.baseTextStyle(
                            color: primaryColor500,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Input your date task',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            filled: true,
                            fillColor: primaryColor500.withOpacity(0.2),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: addProvider.date!,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              addProvider.changeDate(pickedDate);
                            }
                          },
                          controller: TextEditingController(text: '${addProvider.date!.day}/${addProvider.date!.month}/${addProvider.date!.year}'),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Time (optional)',
                              style: AppTextStyles.baseTextStyle(
                                color: primaryColor500,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 24,
                              child: Switch(
                                activeColor: primaryColor500,
                                value: addProvider.time!,
                                onChanged: (value) {
                                  addProvider.changeTime(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Visibility(
                          visible: addProvider.time!,
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true,
                              fillColor: primaryColor500.withOpacity(0.2)
                            ),
                            readOnly: true,
                            onTap: () async {
                              TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                addProvider.changeTimeDates(time);
                              }
                            },
                            controller: TextEditingController(text: '${addProvider.timeDate!.hour}:${addProvider.timeDate!.minute} ${addProvider.defineAmOrPM()}'),
                            onChanged: (value) {
                              // addProvider.changeTime(value);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                bottomSheet: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      if(addProvider.formKey!.currentState!.validate()){
                        ToDo newToDo = ToDo(
                          title: addProvider.title!,
                          description: addProvider.description!,
                          priority: addProvider.priority!,
                          date: addProvider.date!,
                          time: addProvider.timeDate,
                        );
                        print(newToDo.toMap());
                        addProvider.addToDo(newToDo);
                      }
                    },
                    child: addProvider.resultAddTodo == ResultAddTodo.loading
                        ? const CircularProgressIndicator()
                        : const Text('Add To-Do'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
