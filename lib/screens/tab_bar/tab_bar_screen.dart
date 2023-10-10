import 'package:flutter/material.dart';
import 'package:todo_app3/screens/tab_bar/sign_up.dart';

import 'login.dart';

class TabBarScreen extends StatefulWidget {
  static const String routeName = 'tabBar';
  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TDO APP"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Login",
              ),
              Tab(
                text: "SignUp",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginScreen(),
            SignUpScreen(),
          ],
        ),
      ),
    );
  }
}
