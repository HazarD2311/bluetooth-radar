// ignore_for_file: avoid_print

final logger = Logger('radar_debug');

class Logger {
  final String _logSpace;

  Logger(this._logSpace);

  void d(String log) {
    print('-$_logSpace- | $log');
  }
}