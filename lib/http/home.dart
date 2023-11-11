import 'package:demo/http/create_response.dart';
import 'package:demo/http/delete_response.dart';
import 'package:demo/http/get_response.dart';
import 'package:demo/http/navigator.dart';
import 'package:demo/http/update_response.dart';
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
              onPressed: () => toPage(context, Home()), icon: Icon(Icons.home)),
          IconButton(
              onPressed: () => toPage(context, CreateResponse()),
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () => toPage(context, UpdateResponse()),
              icon: Icon(Icons.update)),
          IconButton(
              onPressed: () => toPage(context, DeleteResponse()),
              icon: Icon(Icons.delete)),
        ],
      ),
      body: GetResponse(),
    );
  }
}
