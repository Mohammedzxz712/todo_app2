import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app3/layout/my_provider.dart';
import 'package:todo_app3/screens/splash/splash_screen.dart';
import 'package:todo_app3/shared/style/my_theme.dart';
import 'layout/home_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        },
      ),
    );
  }
}
