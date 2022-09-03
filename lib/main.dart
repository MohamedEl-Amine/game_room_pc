import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'Screens/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  Directory dire = await getApplicationDocumentsDirectory();
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  // Use it only after calling `hiddenWindowAtLaunch`
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(Size(1200, 700));
    await windowManager.setMaximumSize(Size(1200, 700));
    windowManager.show();
  });

  await Hive.initFlutter(dire.path);
  await Hive.openBox('names');
  await Hive.openBox('pespost');
  await Hive.openBox('credit');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(600, 600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FluentApp(
            debugShowCheckedModeBanner: false,
            title: 'Kaya game',
            // theme: ThemeData(),
            home: SplashWidgetScreen());
      },
    );
  }
}
