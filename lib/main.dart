import 'package:demo/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'catalog.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Catalog(),
    );
  }
}
