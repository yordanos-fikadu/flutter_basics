import 'package:demo/http/create_response.dart';
import 'package:demo/http/get_response.dart';
import 'package:demo/http/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
              onPressed: () => toPage(context, CreateResponse()),
              icon: Icon(Icons.edit))
        ],
      ),
      body: CreateResponse(),
    );
  }
}
