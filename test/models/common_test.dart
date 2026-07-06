import 'package:bett_box/models/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Traffic', () {
    test('formats notification speed with per-second suffixes', () {
      final traffic = Traffic(up: 1024, down: 2048);

      expect(traffic.toNotificationSpeedText(), '1024B/s↑  2KB/s↓');
    });
  });
}
