import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:singlepreloader/singlepreloader.dart';

void main() {
  test('check if instance exist', () {
    var instance = SinglePreloader(child: Container());
    expect(instance != null, true);
  });
}
