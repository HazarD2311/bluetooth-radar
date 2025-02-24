import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

import '../common/di.dart';
import '../common/logger.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  // logger.d('start callback dispatcher');

  // if (Locator.isInitialized) return;

  // logger.d('callback dispatcher');
  Locator.instance.backgroundManager.executeTask();
}

class BackgroundWorkManager {
  final workManager = Workmanager();

  void init() {
    // WidgetsFlutterBinding.ensureInitialized();
    workManager.initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    workManager.registerPeriodicTask(
      "bluetoothScanTask",
      "bluetoothScan",
      frequency: Duration(seconds: 7),
    );
  }

  void executeTask() {
    workManager.executeTask((task, inputData) {
      switch (task) {
        case "bluetoothScan":
          Locator.instance.init();
          logger.d('execute from dispatcher');
          break;
      }

      return Future.value(true);
    });
  }
}
