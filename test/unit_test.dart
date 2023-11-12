import 'package:demo/testing/unit_testing.dart';
import 'package:test/test.dart';

void main() {
  group('test counter class', () {
    test('initial value is 0', () {
      expect(Unit().count, 0);
    });
    test('incremented', () {
      Unit unit = Unit();
      unit.increment();
      expect(unit.count, 1);
    });

    test('decremented', () {
      Unit unit = Unit();
      unit.decrement();
      expect(unit.count, -1);
    });
  });
}
// void main() {
//   group('Counter', () {
//     test('value should start at 0', () {
//       expect(Counter().value, 0);
//     });

//     test('value should be incremented', () {
//       final counter = Counter();

//       counter.increment();

//       expect(counter.value, 1);
//     });

//     test('value should be decremented', () {
//       final counter = Counter();

//       counter.decrement();

//       expect(counter.value, -1);
//     });
//   });
// }