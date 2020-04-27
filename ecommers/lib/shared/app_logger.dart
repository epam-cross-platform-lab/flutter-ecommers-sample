import 'package:logger/logger.dart';

class AppLogger {
  AppLogger()
      : _logger = Logger(
            level: Level.debug,
            printer: PrettyPrinter(
                printEmojis: false, methodCount: 0, printTime: false));

  final Logger _logger;

  void log(Level level, String Function() message) {
    _logger.log(level, message());
  }
}
