// ignore_for_file: avoid_print

import 'dart:developer';

final logger = Logger('radar_debug');


class Logger {
  final String _logSpace;

  Logger(this._logSpace);

  void d(String logText) {
    log('-$_logSpace- | $logText');
  }
}
