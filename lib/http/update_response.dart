import 'dart:convert';
import 'package:demo/http/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UpdateResponse extends StatefulWidget {
  const UpdateResponse({super.key});

  @override
  State<UpdateResponse> createState() => _UpdateResponseState();
}

class _UpdateResponseState extends State<UpdateResponse> {
  final idController = TextEditingController();
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  Future<Users>? _featchUser;

  Future<Users> updateRequest(Users user) async {
    final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/users/${user.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()));
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
        child: ListView(
          children: [
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'id'),
                  controller: idController,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'name'),
                  controller: nameController,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'username'),
                  controller: userNameController,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'email'),
                  controller: emailController,
                ),
                height,
                OutlinedButton(
                    onPressed: () => setState(() {
                          Users user = Users(
                              id: int.parse(idController.text),
                              name: nameController.text,
                              username: userNameController.text,
                              email: emailController.text);
                          _featchUser = updateRequest(user);
                        }),
                    child: const Text('Update')),
                height,
                Container(
                  color: Colors.green,
                  height: 50,
                  width: double.infinity,
                  child: const Center(child: Text('Updated Data')),
                ),
                height,
                _featchUser != null
                    ? FutureBuilder(
                        future: _featchUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Users user = snapshot.data!;
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${user.id}'),
                                ),
                                title: Text(user.username),
                                subtitle: Text(user.name),
                                trailing: Text(user.email),
                              ),
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
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
