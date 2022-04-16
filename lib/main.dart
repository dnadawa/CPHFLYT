import 'package:cphflyt/screens/details.dart';
import 'package:cphflyt/screens/login.dart';
import 'package:cphflyt/screens/user_management.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cphflyt/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(397.5, 666),
      builder: ()=>MultiProvider(
        providers: [
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<DatabaseService>(create: (_)=>DatabaseService()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xff1470AF),
            fontFamily: "SF-Pro",
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              color: Color(0xff105A8C)
            )
          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}

