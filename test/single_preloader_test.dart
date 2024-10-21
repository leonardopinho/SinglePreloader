import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singlepreloader/single_preloader.dart';

void main() {
  testWidgets('Loader should not be visible initially', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SinglePreloader(
          indicatorWidget: CircularProgressIndicator(),
          child: Text('Test Child'),
        ),
      ),
    );

    expect(find.text('Test Child'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
