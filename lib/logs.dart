import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(),
);

void logs(Object? message, {String? format = 'd'}) {
  switch (format) {
    case 'd':
      if (!kReleaseMode) logger.d(message);
    case 'i':
      if (!kReleaseMode) logger.i(message);
    case 'w':
      if (!kReleaseMode) logger.w(message);
    case 'e':
      if (!kReleaseMode) logger.e(message);
    case 'v':
      if (!kReleaseMode) logger.v(message);
    default:
  }
}
