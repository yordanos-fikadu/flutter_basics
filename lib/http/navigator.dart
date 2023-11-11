import 'package:flutter/material.dart';

Future<Widget> toPage(BuildContext context, Widget page) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ));
}
