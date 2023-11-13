import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather/common/service/storage.dart';

class Global {
  static late final StorageServices services;

  static init() async {
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

    services = await StorageServices().init();
  }
}
