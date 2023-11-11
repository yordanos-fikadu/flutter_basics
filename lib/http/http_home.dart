import 'dart:convert';
import 'package:demo/http/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpHome extends StatefulWidget {
  const HttpHome({super.key});
  @override
  State<HttpHome> createState() => _HttpHomeState();
}

class _HttpHomeState extends State<HttpHome> {
  Future<List<Users>> featchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
      return json.map((user) => Users.fromJson(user)).toList();
    } else {
      throw Exception('Fail to load user');
    }
  }

  late Future<List<Users>> feachuser;
  @override
  void initState() {
    super.initState();
    feachuser = featchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http'),
      ),
      body: FutureBuilder<List<Users>>(
        future: feachuser,
        builder: (context, AsyncSnapshot<List<Users>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Users user = snapshot.data![index];
                  return Card(
                    elevation: 8,
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${user.id}')),
                      title: Text(user.name),
                      subtitle: Text(user.username),
                      trailing: Text(user.email),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
