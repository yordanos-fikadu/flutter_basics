import 'dart:convert';
import 'package:demo/http/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DeleteResponse extends StatefulWidget {
  const DeleteResponse({super.key});

  @override
  State<DeleteResponse> createState() => _DeleteResponseState();
}

class _DeleteResponseState extends State<DeleteResponse> {
  final idController = TextEditingController();
  Future<Users>? featch;
  @override
  void initState() {
    super.initState();
    featch = featchData();
  }

  Future<Users> featchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (response.statusCode == 200) {
      return Users.fromjson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Users');
    }
  }

  Future<Users> deleteRequest(int id) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return Users.fromjson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update User');
    }
  }

  @override
  Widget build(BuildContext context) {
    const height = SizedBox(
      height: 30,
    );
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FutureBuilder(
          future: featch,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Users user = snapshot.data!;
              return Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'id'),
                    controller: idController,
                  ),
                  height,
                  OutlinedButton(
                      onPressed: () => setState(() {
                            featch =
                                deleteRequest(int.parse(idController.text));
                          }),
                      child: const Text('Delete')),
                  height,
                  Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${user.id}'),
                      ),
                      title: Text(user.username),
                      subtitle: Text(user.name),
                      trailing: Text(user.email),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
