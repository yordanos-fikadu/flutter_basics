import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
   MyWidget({super.key, required this.name});

  // const MyWidget({
  //   super.key,
  //   required this.title,
  //   required this.message,
  //   required this.textKey,
  // });
   String name;
  // final String title;
  // final String message;
  // final Key textKey;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Column(
          children: [
            TextField(
              controller: nameController,
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    widget.name = nameController.text;
                  });
                },
                child: const Text('save')),
            Text(widget.name) 
            // Text(key: widget.textKey, widget.message),
            // Text(widget.message)
          ],
        ),
      ),
    );
  }
}
