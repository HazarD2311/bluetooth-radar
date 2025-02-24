import 'package:flutter/widgets.dart';

import '../managers/background_work_manager.dart';
import '../managers/bluetooth_scanner_manager.dart';

class Locator {
  Locator._();

  static Locator? _instance;
  static bool _isInitialized = false;

  static Locator get instance {
    if (_instance == null) {
      _instance = Locator._();
      _isInitialized = true;
    }

    return _instance!;
  }

  static bool get isInitialized => _isInitialized;

  final backgroundManager = BackgroundWorkManager();
  final btScanner = BluetoothScannerManager(
    scanDurationSec: 10,
    scanPauseSec: 5,
  );
  late final historyManager = HistoryScanResultManager(btScanner);
  late final findManager = FindCurrentNameManager(
    btScanner,
    remotedIds: {
      'F8:4D:89:CE:6D:33',
      '3C:B0:ED:3E:ED:65',
    },
  );

  void init() {
    btScanner.startScan();
    historyManager.init();
    findManager.init();
    backgroundManager.init();
  }
}
