import 'package:bluetooth_radar_demo/ui/main_page.dart';
import 'package:flutter/material.dart';

import 'common/di.dart';
import 'common/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Locator.instance.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Подписываемся на события жизненного цикла
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Отписываемся
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        logger.d("Приложение в активном состоянии");
        break;
      case AppLifecycleState.inactive:
        logger.d("Приложение неактивно (например, перекрыто другим приложением)");
        break;
      case AppLifecycleState.paused:
        logger.d("Приложение в фоновом режиме");
        break;
      case AppLifecycleState.detached:
        logger.d("Приложение завершено (убито)");
        break;
      case AppLifecycleState.hidden:
        logger.d("Приложение завершено (убито)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Bluetooth Radar',
      home: MainPage(),
    );;
  }
}
