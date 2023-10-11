import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app3/layout/my_provider.dart';
import 'package:todo_app3/screens/tab_bar/login.dart';

import '../screens/tab_bar/tab_bar_screen.dart';
import '../screens/task/bottom_sheet.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'layout';

  const HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, TabBarScreen.routeName, (route) => false);
            },
            icon: const Icon(
              Icons.login,
            ),
          ),
        ],
        titleSpacing: 40,
        title: Text('To Do List ${provider.user?.name}'),
      ),
      body: provider.screen[provider.currentIndex],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        notchMargin: 7,

        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: provider.currentIndex,
          onTap: (value) {
            provider.changeBottomNav(value);
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon_list.png'),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon_settings.png'),
                ),
                label: ''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(context);
        },
        child: const Icon(Icons.add),
        shape: CircleBorder(
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BottomSheetItem(),
      ),
    );
  }
}
