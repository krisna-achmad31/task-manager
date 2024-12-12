import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/time.dart';
import 'package:task_manager/model/add_model/add_model.dart';

import '../../../helper/database_helper.dart';

enum ResultAddTodo { loading, success, error }

class AddProvider extends ChangeNotifier{
  AddProvider(BuildContext context){
    _context = context;
    _formKey = GlobalKey<FormState>();
  }

  GlobalKey<FormState>? _formKey;
  GlobalKey<FormState>? get formKey => _formKey;


  BuildContext? _context;
  BuildContext? get context => _context;

  String? _title = '';
  String? get title => _title;

  changeTitle(String value){
    _title = value;
    notifyListeners();
  }

  String? _description = '';
  String? get description => _description;

  changeDescription(String value){
    _description = value;
    notifyListeners();
  }

  DateTime? _date = DateTime.now();
  DateTime? get date => _date;

  changeDate(DateTime value){
    _date = value;
    notifyListeners();
  }

  DateTime? _timeDate = DateTime.now();
  DateTime? get timeDate => _timeDate;

  changeTimeDate(DateTime value){
    _timeDate = value;
    notifyListeners();
  }

  bool? _time = false;
  bool? get time => _time;

  changeTime(bool value){
    _time = value;
    notifyListeners();
  }

  String? _priority = 'High';
  String? get priority => _priority;

  changePriority(String value){
    _priority = value;
    notifyListeners();
  }

  defineAmOrPM() {
    if(_timeDate!.hour >= 12){
      return 'PM';
    }else{
      return 'AM';
    }
  }

  void changeTimeDates(TimeOfDay time) {
    _timeDate = DateTime(_timeDate!.year, _timeDate!.month, _timeDate!.day, time.hour, time.minute);
    notifyListeners();
  }

  ResultAddTodo? _resultAddTodo;
  ResultAddTodo? get resultAddTodo => _resultAddTodo;

  addToDo(ToDo todo) async {
    _resultAddTodo = ResultAddTodo.loading;
    notifyListeners();
    try {
      await DatabaseHelper().insertToDo(todo);
      _resultAddTodo = ResultAddTodo.success;
      Navigator.pop(context!);
    } catch (e) {
      _resultAddTodo = ResultAddTodo.error;
    }
    notifyListeners();
  }

  Future<void> updateToDoDate(ToDo todo, DateTime newDate) async {
    todo.date = newDate;
    await DatabaseHelper().updateToDo(todo);
  }
}