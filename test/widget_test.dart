import 'package:demo/testing/widget_testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  // testWidgets('MyWidget has a title and message', (tester) async {
  //   // Create the widget by telling the tester to build it.
  //   await tester.pumpWidget(const MyWidget(
  //     title: 'widget test',
  //     message: 'message',
  //     textKey: Key('textKey'),
  //   ));
  //   // Create the Finders.
  //   final titleFinder = find.text('widget test');
  //   final messageFinder = find.text('message');
  //   final textKey = find.byKey(const Key('textKey'));
  //   // Use the `findsOneWidget` matcher provided by flutter_test to
  //   // verify that the Text widgets appear exactly once in the widget tree.
  //   expect(titleFinder, findsOneWidget);
  //   expect(messageFinder, findsWidgets);
  //   expect(textKey, findsOneWidget);
  // });
  // testWidgets('find a specific instance', (widgetTester) async {
  //   const padding = Padding(padding: const EdgeInsets.all(9));
  //   await widgetTester.pumpWidget(Container(
  //     child: padding,
  //   ));
  //   expect(find.byWidget(padding), findsOneWidget);
  // });
  testWidgets('Add a name', (tester) async {
    // Enter text code...
    await tester.pumpWidget(MyWidget(name: 'me',));
    // Enter 'yordi' into a textField
    await tester.enterText(find.byType(TextField), 'yordi');
    // Tap the save button.
    await tester.tap(find.byType(OutlinedButton));
    // Rebuild the widget after the state has changed.
    await tester.pump();
    // Expect to find the item on screen.
    expect(find.text('yordi'), findsOneWidget);
  });
}
