import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singlepreloader/single_preloader.dart';

void main() {
  testWidgets('Loader should appear and disappear on show() and hide()', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SinglePreloader(
          indicatorWidget: CircularProgressIndicator(),
          child: Text('Test Child'),
        ),
      ),
    );

    final preloaderState = SinglePreloader.of(tester.element(find.text('Test Child')));

    expect(find.byType(CircularProgressIndicator), findsNothing);

    preloaderState?.show();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    preloaderState?.hide();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}