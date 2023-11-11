import 'package:demo/provider/item.dart';
import 'package:demo/provider/provider.dart';
import 'package:test/test.dart';

void main() {
  test('item are inserted', () {
    var cartModel = CartModel();
    cartModel.add(Item(number: 1, name: 'one'));
    expect(cartModel.item.length, 1);
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