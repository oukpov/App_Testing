import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDB {
  late Database db;

  Future<void> createUser() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ItemDB4.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS ItemList4( 
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            items VARCHAR(255) NOT NULL,
            checks INTEGER NOT NULL
          );
        ''');
      },
    );
  }

  Future<void> updateItem(int id, String newItem, int newCheck) async {
    await db.update(
      'ItemList4',
      {'items': newItem, 'checks': newCheck},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> done(int id, int newCheck) async {
    await db.update(
      'ItemList4',
      {'checks': newCheck},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delelteIem(int id) async {
    await db.delete(
      'ItemList4',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Deleted succesfuly');
  }
}
