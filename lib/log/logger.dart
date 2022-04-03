enum LogLevel { none, debug, info, error }

class Logger {
  String component;
  LogLevel? level;
  Logger(this.component) {
    print('Logger: $component');
    level = LogLevel.error;
  }

  void logInfo(String? message) {
    if (level != LogLevel.none) {
      print('Log Info: $component: $message');
    }
  }

  void logError(String? message) {
    if (level == LogLevel.error) {
      printError('Log Error: $component: $message');
    }
  }

  void logDebug(String? message) {
    if (level == LogLevel.debug || level == LogLevel.error) {
      printWarning('Log Debug: $component: $message');
    }
  }

  void printWarning(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }
}
