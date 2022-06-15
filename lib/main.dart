import 'package:cphflyt/controllers/bottom_nav_controller.dart';
import 'package:cphflyt/controllers/driver_assign_controller.dart';
import 'package:cphflyt/controllers/driver_controller.dart';
import 'package:cphflyt/controllers/filter_controller.dart';
import 'package:cphflyt/controllers/user_management_controller.dart';
import 'package:cphflyt/services/auth_service.dart';
import 'package:cphflyt/services/database_service.dart';
import 'package:cphflyt/services/storage_service.dart';
import 'package:cphflyt/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cphflyt/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cphflyt/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");
  String oneSignalAppId = dotenv.env['ONESIGNAL'] ?? "";
  OneSignal.shared.setAppId(oneSignalAppId);
  OneSignal.shared.promptUserForPushNotificationPermission();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(397.5, 666),
      builder: (context, widget)=>MultiProvider(
        providers: [
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<DriverController>(create: (_) => DriverController()),
          Provider<StorageService>(create: (_) => StorageService()),
          ChangeNotifierProvider<DatabaseService>(create: (_)=>DatabaseService()),
          ChangeNotifierProvider<BottomNavController>(create: (_)=>BottomNavController()),
          ChangeNotifierProvider<FilterController>(create: (_)=>FilterController()),
          ChangeNotifierProvider<UserManagementController>(create: (_)=>UserManagementController()),
          ChangeNotifierProvider<DriverAssignController>(create: (_)=>DriverAssignController()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            fontFamily: "SF-Pro",
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              color: kPrimaryColor
            )
          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}

