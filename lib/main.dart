import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app3/layout/my_provider.dart';
import 'package:todo_app3/screens/splash/splash_screen.dart';
import 'package:todo_app3/screens/tab_bar/login.dart';
import 'package:todo_app3/screens/tab_bar/tab_bar_screen.dart';
import 'package:todo_app3/shared/style/my_theme.dart';
import 'firebase_options.dart';
import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: SplashScreen.routeName,
        routes: {
          HomeLayout.routeName: (context) => HomeLayout(),
          SplashScreen.routeName: (context) => SplashScreen(),
          TabBarScreen.routeName: (context) => TabBarScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
        },
      ),
    );
  }
}
