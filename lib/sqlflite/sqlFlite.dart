import 'package:demo/sqlflite/sql_methods.dart';
import 'package:demo/sqlflite/users.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlFlite extends StatefulWidget {
  const SqlFlite({Key? key}) : super(key: key);

  @override
  State<SqlFlite> createState() => _SqlFliteState();
}

class _SqlFliteState extends State<SqlFlite> {
  late Future<Database?> initializeDatabase;
  // bool _isInserted = false;
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initializeDatabase = createDatabase();
  }

  Widget layout(bool isInsert, int? updatedId) {
    return Column(
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
          decoration: const InputDecoration(hintText: 'email'),
          controller: emailController,
        ),
        OutlinedButton(
            onPressed: () async {
              isInsert
                  ? await insertUser(int.parse(idController.text),
                      nameController.text, emailController.text)
                  : update(updatedId!, int.parse(idController.text),
                      nameController.text, emailController.text);
              idController.clear();
              nameController.clear();
              emailController.clear();
            },
            child: const Text('Create')),
      ],
    );
  }

  Future<void> showAlertDialog(
      String title, Widget content, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('clear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqlite'),
      ),
      body: FutureBuilder(
        future: initializeDatabase,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Database initialization is complete
              return FutureBuilder(
                future: query(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final value = snapshot.data![index];
                          Users user = Users.fromMap(value);
                          return Card(
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${user.id}'),
                              ),
                              title: Text(user.name),
                              subtitle: Text(user.email),
                              trailing: IconButton(
                                onPressed: () async {
                                  showAlertDialog('Update',
                                      layout(false, user.id), context);
                                },
                                icon: const Icon(Icons.update),
                              ),
                              onTap: () async {
                                await delete(user.id);
                                showAlertDialog(
                                    'Delete',
                                    Text('User deleted successfully!'),
                                    context);
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No data available.'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAlertDialog('Insert', layout(true, null), context);
        },
      ),
    );
  }
}
