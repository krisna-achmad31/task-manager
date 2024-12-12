import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../helper/database_helper.dart';
import '../../../model/add_model/add_model.dart';

enum ResultLoadingData { loading, success, error }
enum ResultLoadingDataCustom { loading, success, error }

class HomeProvider extends ChangeNotifier {
  HomeProvider(BuildContext context) {
    _context = context;
    _currentDate = DateTime.now();
    _priority = 'All';
    _monthCustom = int.parse(DateFormat('M').format(DateTime.now()));
    initCustomTodo();
    getToDoCustom();
    getTodayInformation();
    getToDo();
  }

  BuildContext? _context;

  BuildContext? get context => _context;

  String? _today = '';

  String? get today => _today;

  String? _date = '';

  String? get date => _date;

  String? _month = '';

  String? get month => _month;

  String? _day = '';

  String? get day => _day;

  String? _priority = 'All';

  String? get priority => _priority;

  changePriority(String value) async {
    _priority = value;
    if (value == 'All') {
      getToDo();
    } else {
      await getToDo();
      print('extract');
      _todos = _todos.where((element) => element.priority == value).toList();
    }
    notifyListeners();
  }

  bool? _isToday = true;

  bool? get isToday => _isToday;

  changeIsToday(bool value) {
    _isToday = value;
    if(value){
      getToDo();
    } else {
      getToDoCustom();
    }
    notifyListeners();
  }

  void getTodayInformation() {
    DateTime now = DateTime.now();
    _today = now.day.toString();
    _date = now.day.toString();
    _month = DateFormat('MMM').format(now).toUpperCase();
    _day = DateFormat('EEEE').format(now);
    notifyListeners();
  }

  getTodayToDoProgressFromDb() {}

  void openDropDown() {
    print('openDropDown');
  }

  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  ResultLoadingData? _resultLoadingData;

  ResultLoadingData? get resultLoadingData => _resultLoadingData;

  getToDo() async {
    _resultLoadingData = ResultLoadingData.loading;
    notifyListeners();
    try {
      var result = await DatabaseHelper().getToDos();
      await getToDoToday(result);
      await getPriorityInformation();

      _resultLoadingData = ResultLoadingData.success;
      notifyListeners();
    } catch (e) {
      _resultLoadingData = ResultLoadingData.error;
      notifyListeners();
    }
  }

  getToDoToday(List<ToDo> result) {
    _todos = result.where((element) => changeToDateFormatFromString(element.date) == DateFormat('yyyy-MM-dd').format(DateTime.now())).toList();
    notifyListeners();
  }

  changeToDateFormatFromString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void changeStatus(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    DatabaseHelper().updateToDoStatus(_todos[index]);
    getToDo();
    notifyListeners();
  }

  int? _maxHighPriority = 0;

  int? get maxHighPriority => _maxHighPriority;

  int? _maxMediumPriority = 0;

  int? get maxMediumPriority => _maxMediumPriority;

  int? _maxLowPriority = 0;

  int? get maxLowPriority => _maxLowPriority;

  int? _maxAllPriority = 1;

  int? get maxAllPriority => _maxAllPriority;

  int? _highDone = 0;

  int? get highDone => _highDone;

  int? _mediumDone = 0;

  int? get mediumDone => _mediumDone;

  int? _lowDone = 0;

  int? get lowDone => _lowDone;

  int? _allDone = 1;

  int? get allDone => _allDone;

  getPriorityInformation() {
    _maxHighPriority = _todos.where((element) => element.priority == 'High').toList().length;
    _maxMediumPriority = _todos.where((element) => element.priority == 'Medium').toList().length;
    _maxLowPriority = _todos.where((element) => element.priority == 'Low').toList().length;
    _maxAllPriority = _todos.length;
    _highDone = _todos.where((element) => element.priority == 'High' && element.isDone == true).toList().length;
    _mediumDone = _todos.where((element) => element.priority == 'Medium' && element.isDone == true).toList().length;
    _lowDone = _todos.where((element) => element.priority == 'Low' && element.isDone == true).toList().length;
    _allDone = _todos.where((element) => element.isDone == true).toList().length;
    calculatePercentageAllPriority();
    if(allDone == 0 && maxAllPriority == 0){
      _allDone = 1;
      _maxAllPriority = 1;
      _percentageAllPriority = '0';
    }
    notifyListeners();
  }

  String? _percentageAllPriority = '0';

  String? get percentageAllPriority => _percentageAllPriority;

  calculatePercentageAllPriority() {
    if (_maxAllPriority != 0) {
      _percentageAllPriority = (_allDone! / _maxAllPriority! * 100).round().toString();
    }
  }

  changeToMMM(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
  }

  changeToDay(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
  }

  List<ToDo> _todosCustom = [];

  List<ToDo> get todosCustom => _todosCustom;

  ResultLoadingDataCustom? _resultLoadingDataCustom;
  ResultLoadingDataCustom? get resultLoadingDataCustom => _resultLoadingDataCustom;

  getToDoCustom() async {
    _resultLoadingDataCustom = ResultLoadingDataCustom.loading;
    notifyListeners();
    try {
      var result = await DatabaseHelper().getToDos();
      defineCustomWithSpecificMonth(result);
      print(todosCustom.length);
      _resultLoadingDataCustom = ResultLoadingDataCustom.success;
      notifyListeners();
    } catch (e) {
      _resultLoadingDataCustom = ResultLoadingDataCustom.error;
      notifyListeners();
    }
  }

  void defineCustomWithSpecificMonth(List<ToDo> result) {
    _todosCustom = result.where((element) => DateFormat('M').format(element.date) == monthCustom.toString()).toList();
    notifyListeners();
  }

  int? _monthCustom = 1;
  int? get monthCustom => _monthCustom;

  DateTime? _currentDate;
  DateTime? get currentDate => _currentDate;

  String? _currentMonth;
  String? get currentMonth => _currentMonth;

  String? _previousMonth;
  String? get previousMonth => _previousMonth;

  String? _nextMonth;
  String? get nextMonth => _nextMonth;

  initCustomTodo(){
    _currentMonth = DateFormat('MMM').format(_currentDate!);
    _previousMonth = DateFormat('MMM').format(DateTime(_currentDate!.year, _currentDate!.month - 1));
    _nextMonth = DateFormat('MMM').format(DateTime(_currentDate!.year, _currentDate!.month + 1));
    notifyListeners();
  }

  void previousMonthCustom() async {
    _currentDate = DateTime(_currentDate!.year, _currentDate!.month - 1);
    await initCustomTodo();
    changeMonth(_currentDate!.month);
    getToDoCustom();
    notifyListeners();
  }

  void nextMonthCustom() async {
    _currentDate = DateTime(_currentDate!.year, _currentDate!.month + 1);
    await initCustomTodo();
    changeMonth(_currentDate!.month);
    getToDoCustom();
    notifyListeners();
  }

  void changeMonth(int month) {
    _monthCustom = month;
    getToDoCustom();
    notifyListeners();
  }

  void changeStatusCustom(int index, DateTime date, int id) {
    print('id $id');
    _todosCustom[index].isDone = !_todosCustom[index].isDone;
    print(_todosCustom[index].isDone);
    findDataAndChangeStatus(_todosCustom[index], date, id);
    getToDoCustom();
    notifyListeners();
  }

  void findDataAndChangeStatus(ToDo todosCustom, DateTime date, int id) {
    print(todosCustom.title);
    for (int i = 0; i < _todosCustom.length; i++) {
      if (_todosCustom[i].id == id) {
        print('found');
        print(_todosCustom[i].title);
        print(_todosCustom[i].date);
        _todosCustom[i].isDone = !todosCustom.isDone!;
        DatabaseHelper().updateToDoStatus(_todosCustom[i]);
      }
    }
  }


}
