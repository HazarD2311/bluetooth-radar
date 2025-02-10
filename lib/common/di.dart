import '../managers/bluetooth_scanner_manager.dart';

class Locator {
  Locator._();

  static final Locator _instance = Locator._();

  static Locator get instance => _instance;

  final btScanner = BluetoothScannerManager(
    scanPeriodicSec: 20,
    scanDurationSec: 10,
  );
  late final historyManager = HistoryScanResultManager(btScanner);
  late final findManager = FindCurrentNameManager(
    btScanner,
    remotedIds: {
      'F8:4D:89:CE:6D:33',
    },
  );

  void init() {
    btScanner.init();
    historyManager.init();
    findManager.init();
  }
}
