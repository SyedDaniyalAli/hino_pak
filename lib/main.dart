import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/add_complain_screen/add_complain_screen.dart';
import 'screens/complain_screen/complain_screen.dart';
import 'screens/forget_pwd_screen/forget_pwd_screen.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/registration_screen/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hino Pak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.lato().fontFamily,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
            titleTextStyle: Theme.of(context).textTheme.headline6,
          )),
      routes: {
        '/': (context) => LoginPage(),
        Registration.routeName: (context) => Registration(),
        AddComplainScreen.routeName: (ctx) => AddComplainScreen(),
        LoginPage.routeName: (ctx) => LoginPage(),
        ComplainScreen.routeName: (ctx) => ComplainScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
      },
    );
  }
}