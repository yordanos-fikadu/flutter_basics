import 'package:demo/sqlflite/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

Future<int?> insertUser(int id,String name,String email) async {
  if (database == null) {
    throw Exception('Database not initialized.');
  }
  Users users =  Users(id: id, name: name, email: email);
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

Future<int> update(int idUpdate,int id,String name,String email) async {
  Users users =  Users(id: id, name: name, email: email);
  return await database!.update(
    'Information',
    users.toMap(),
    where: 'id=$idUpdate',
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
