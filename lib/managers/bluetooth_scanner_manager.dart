import 'dart:async';

import 'package:bluetooth_radar_demo/managers/notification_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../common/logger.dart';
import '../common/utils.dart';

typedef Id = String;

class BluetoothScannerManager {
  final int _scanDurationSec;
  final int _scanPauseSec;

  BluetoothScannerManager({
    required int scanDurationSec,
    required int scanPauseSec,
  })  : _scanDurationSec = scanDurationSec,
        _scanPauseSec = scanPauseSec;

  Stream<bool> get isScanning => FlutterBluePlus.isScanning;

  Stream<Map<Id, DeviceResult>> get result =>
      FlutterBluePlus.scanResults.map((result) => Map.fromEntries(
            result
                .map<DeviceResult>(
                  (it) => it.toDto,
                )
                .map(
                  (it) => MapEntry(it.remoteId, it),
                ),
          ));

  Timer? _timer;

  void startScan() {
    _timer ??= Timer.periodic(
      Duration(seconds: _scanPauseSec) + Duration(seconds: _scanDurationSec),
      (timer) async {
        logger.d('start scanning');
        await FlutterBluePlus.startScan(timeout: Duration(seconds: _scanDurationSec));
        _timer = null;
        logger.d('end scanning');
      },
    );
  }
}

class HistoryScanResultManager {
  HistoryScanResultManager(this._scannerManager);

  final BluetoothScannerManager _scannerManager;

  final StreamController<Map<Id, DeviceResult>> results = StreamController();
  final Map<Id, DeviceResult> _lastResults = {};

  void init() {
    _scannerManager.result.listen((newResults) {
      updateFromMap(
        _lastResults,
        newResults,
        (oldValue, newValue) => oldValue == newValue ? oldValue : newValue,
      );
      results.add(_lastResults);
    });
  }
}

class FindCurrentNameManager {
  FindCurrentNameManager(this._scannerManager, this._notificationManager, {required this.remotedIds});

  final Set<String> remotedIds;

  final BluetoothScannerManager _scannerManager;
  final SoundNotificationManager _notificationManager;

  final StreamController<List<DeviceResult>> results = StreamController.broadcast();
  List<DeviceResult> _lastResults = [];

  void init() {
    _scannerManager.result
        .map((result) =>
            result.values.where((value) => remotedIds.contains(value.remoteId)).toList())
        .listen(
      (data) {
        _lastResults = data;
        results.add(_lastResults);
      },
    );
    _scannerManager.isScanning.listen((isScanning) {
      if (isScanning) {
        _lastResults = [];
        results.add(_lastResults);
      }
    });
    results.stream.where((it) => it.isNotEmpty).throttleTime(Duration(seconds: 5)).listen(
      (it) {
        _notificationManager.showNotification('Нашёл сокровище рядом!', it.toString(), it.first.updated.millisecond);
        logger.d('founded $it');
      },
    );
  }
}

class DeviceResult {
  final Id remoteId;
  final String btName;

  final DateTime updated;

  DeviceResult({
    required this.remoteId,
    required this.btName,
    DateTime? updated,
  }) : updated = updated ?? DateTime.now();

  String get _formattedDate => DateFormat.Hms().format(updated);

  @override
  bool operator ==(Object other) {
    if (other is! DeviceResult) return false;
    return (other.remoteId == remoteId) && (other.btName == btName);
  }

  @override
  String toString() => '{$remoteId : $btName} at: $_formattedDate';

  @override
  int get hashCode => remoteId.hashCode ^ btName.hashCode;
}

extension on ScanResult {
  DeviceResult get toDto => DeviceResult(
        remoteId: device.remoteId.toString(),
        btName: device.platformName.toString(),
      );
}
