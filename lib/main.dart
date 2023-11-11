import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/features/add_location/view/add_location.dart';
import 'package:flutter_weather/features/home/view/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const ProviderScope(child: MyApp()));
}

GlobalKey<NavigatorState> navkey = GlobalKey();

class RoutesConstant {
  static const String Home = "/";
  static const String SavedLocation = "/savedLocation";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: navkey,
        title: 'Flutter Weather',
        theme: ThemeData(
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
        ),
        initialRoute: RoutesConstant.Home,
        routes: {
          RoutesConstant.Home: (context) => const Home(),
          RoutesConstant.SavedLocation: (context) => const SavedLocation()
        },
      ),
    );
  }
}
