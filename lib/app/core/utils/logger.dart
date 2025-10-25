import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // Stack trace lines
    errorMethodCount: 3,
    colors: true,
    printEmojis: true,
  ),
  level: kReleaseMode ? Level.off : Level.debug, // disable in release
);

// Shortcut functions
void printE(String message) => _logger.e(message);
void printW(String message) => _logger.w(message);
void printI(String message) => _logger.i(message);
void printD(String message) => _logger.d(message);
