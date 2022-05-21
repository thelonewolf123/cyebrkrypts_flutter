enum LogLevel { none, debug, info, error }

class Logger {
  String component;
  LogLevel? level;
  Logger(this.component) {
    printInfo('Logger: $component');
    level = LogLevel.none;
  }

  void logInfo(String? message) {
    if (level != LogLevel.none) {
      printInfo('Log Info: $component: $message');
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

  void printInfo(String text) {
    print('\x1B[32m$text\x1B[0m');
  }
}
