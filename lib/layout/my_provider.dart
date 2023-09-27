import 'package:flutter/material.dart';
import 'package:todo_app3/screens/setting/setting_tab.dart';
import 'package:todo_app3/screens/task/task_tab.dart';

class MyProvider extends ChangeNotifier {
  int currentIndex = 0;
  void changeBottomNav(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screen = [TaskTab(), SettingTab()];
}
