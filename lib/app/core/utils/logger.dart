import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  // Singleton pattern
  AppLogger._privateConstructor();
  static final AppLogger instance = AppLogger._privateConstructor();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1, // Stack trace lines
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
    level: kReleaseMode ? Level.off : Level.debug, // disable in release
  );

  void e(String message, [dynamic error]) {
    _logger.e(message, error: error);
  }

  void w(String message) {
    _logger.w(message);
  }

  void i(String message) {
    _logger.i(message);
  }

  void d(String message) {
    _logger.d(message);
  }
}

// Shortcut functions
void printE(String message) => AppLogger.instance.e(message);
void printW(String message) => AppLogger.instance.w(message);
void printI(String message) => AppLogger.instance.i(message);
void printD(String message) => AppLogger.instance.d(message);
