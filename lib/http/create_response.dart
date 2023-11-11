import 'dart:convert';
import 'package:demo/http/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CreateResponse extends StatefulWidget {
  const CreateResponse({super.key});

  @override
  State<CreateResponse> createState() => _CreateResponseState();
}

class _CreateResponseState extends State<CreateResponse> {
  final idController = TextEditingController();
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  Future<Users>? _featchUser;

  Future<Users> createRequest(Users user) async {
    final response =
        await http.post(Uri.parse('https://jsonplaceholder.typicode.com/users'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(user.toMap()));
    if (response.statusCode == 201) {
      return Users.fromjson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create User');
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
                          _featchUser = createRequest(user);
                        }),
                    child: const Text('Create')),
                height,
                Container(
                  color: Colors.green,
                  height: 50,
                  width: double.infinity,
                  child: const Center(child: Text('Created Data')),
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
