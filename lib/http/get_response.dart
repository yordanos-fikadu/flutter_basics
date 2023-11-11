import 'package:demo/http/https_method.dart';
import 'package:demo/http/users.dart';
import 'package:flutter/material.dart';

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
