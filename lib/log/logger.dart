enum LogLevel { none, debug, info, error }

class Logger {
  String component;
  LogLevel? level;
  Logger(this.component) {
    print('Logger: $component');
    level = LogLevel.info;
  }

  void logInfo(String? message) {
    if (level != LogLevel.none) {
      print('Log Info: $component: $message');
    }
  }

  void logError(String? message) {
    if (level == LogLevel.error) {
      print('Log Error: $component: $message');
    }
  }

  void logDebug(String? message) {
    if (level == LogLevel.debug || level == LogLevel.error) {
      print('Log Debug: $component: $message');
    }
  }
}
