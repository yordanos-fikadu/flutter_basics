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

  @override
  void initState() {
    super.initState();
    initializeDatabase = createDatabase();
    // initializeDatabase.then((_) {
    //   // Insert a user when the database is initialized
    //   insertUser();
    // });
  }

  Database? database;

  Future<Database?> createDatabase() async {
    if (database != null) return database;
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Information (id INTEGER PRIMARY KEY, name TEXT, email TEXT)');
      },
    );
    return database;
  }

  Future<int?> insertUser() async {
    if (database == null) {
      throw Exception('Database not initialized.');
    }

    Users users = const Users(id: 1, name: 'yordi', email: 'yordi@gmail.com');
    // Users users = const Users(id: 2, name: 'nadom', email: 'nadom@gmail.com');
    print(await database!.insert(
      'Information',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ));
    return await database!.insert(
      'Information',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> query() async {
    if (database == null) {
      throw Exception('Database not initialized.');
    }

    return await database!.query('Information');
  }

  Future<int> update(int id) async {
    Users users = const Users(id: 2, name: 'yordi', email: 'yordi@gmail.com');
    return await database!.update(
      'Information',
      users.toMap(),
      where: 'id=$id',
    );
  }

  Future<void> delete(int id) async {
    if (database == null) {
      throw Exception('Database not initialized.');
    }

    await database!.delete(
      'Information',
      where: 'id=$id',
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
                          return Card(
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${snapshot.data![index]['id']}'),
                              ),
                              title: Text('${snapshot.data![index]['name']}'),
                              subtitle:
                                  Text('${snapshot.data![index]['email']}'),
                              trailing: IconButton(
                                onPressed: () async =>
                                    await delete(snapshot.data![index]['id']),
                                icon: const Icon(Icons.delete),
                              ),
                              onTap: () async =>
                                  await update(snapshot.data![index]['id']),
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
    );
  }
}
