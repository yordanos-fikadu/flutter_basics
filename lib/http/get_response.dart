import 'dart:convert';
import 'dart:io';

import 'package:demo/http/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetResponse extends StatefulWidget {
  const GetResponse({super.key});
  @override
  State<GetResponse> createState() => _GetResponseState();
}

class _GetResponseState extends State<GetResponse> {
  late Future<List<Users>> featch;
  @override
  void initState() {
    super.initState();
    featch = featchData();
  }

  Future<List<Users>> featchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users'), headers: {
      // Send authorization headers to the backend.
      HttpHeaders.authorizationHeader: 'Basic your_api_token_here'
    });
    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body) as List<dynamic>;
      return users.map((user) => Users.fromjson(user)).toList();
    } else {
      throw Exception('Failed to load Users');
    }
  }

  @override
  Widget build(BuildContext contstfext) {
    return FutureBuilder(
      future: featch,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Users user = snapshot.data![index];
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
            },
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
    );
  }
}
