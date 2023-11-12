import 'package:demo/http/home.dart';
import 'package:demo/provider/catalog.dart';
import 'package:demo/sqlflite/sqlFlite.dart';
import 'package:flutter/material.dart';

void main() {
  // Initialize the sqflite database factory
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: SqlFlite(),
  ));
}
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => CartModel()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Catalog(),
    );
  }
}
