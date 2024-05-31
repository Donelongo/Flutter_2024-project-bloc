import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDatabaseConnection() async {
  final databasePath = await getDatabasesPath();
  
  final path = join(databasePath, 'tokens.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tokens(userId TEXT PRIMARY KEY, token TEXT)',
      );
    },
    version: 1,
  );
}


Future<void> storeToken(String userId, String token) async {
  final db = await openDatabaseConnection();

  await db.insert(
    'tokens',
    {
      'userId': userId,
      'token': token,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


Future<String?> retrieveToken() async {
  final db = await openDatabaseConnection();

  final List<Map<String, dynamic>> maps = await db.query('tokens');

  if (maps.isNotEmpty) {
    return maps.first['token'] as String?;
  }
  return null;
}

Future<String?> retrieveUserId() async {
  final db = await openDatabaseConnection();

  final List<Map<String, dynamic>> maps = await db.query('tokens');

  if (maps.isNotEmpty) {
    return maps.first['userId'] as String?;
  }
  return null;
} // try it now
