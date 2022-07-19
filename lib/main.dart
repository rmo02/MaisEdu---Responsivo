import 'package:resposividade/pages/bar_item_page.dart';
import 'package:resposividade/pages/home_page.dart';
import 'package:resposividade/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


void main() {
  runApp(const MyApp());
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginPage(),
          );
        }
    );

  }
}