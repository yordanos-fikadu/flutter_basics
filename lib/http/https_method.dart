import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:demo/http/users.dart';

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