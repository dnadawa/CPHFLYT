import 'package:cphflyt/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(397.5, 666),
      builder: ()=>MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff1470AF),
          fontFamily: "SF-Pro",
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            color: Color(0xff105A8C)
          )
        ),
        home: Details(),
      ),
    );
  }
}

