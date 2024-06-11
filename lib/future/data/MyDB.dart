import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDB {
  late Database db;

  Future<void> createUser() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'List_To_Do_DB.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS list_To_do_Table( 
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            items VARCHAR(255) NOT NULL,
            checks INTEGER NOT NULL,
            pro_id INTEGER NOT NULL,
            pro_name VARCHAR(255) NOT NULL,
           create_date DATE DEFAULT (DATE('now'))
          );
        ''');
      },
    );
  }

  Future<void> deleteAllItems() async {
    await db.rawDelete('DELETE FROM list_To_do_Table');
    await db.execute('VACUUM');
    await db.close();
  }

  Future<void> updateItem(
      int id, String newItem, int newCheck, int proID, String proName) async {
    await db.update(
      'list_To_do_Table',
      {
        'items': newItem,
        'checks': newCheck,
        'pro_id': proID,
        'pro_name': proName,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> done(int id, int newCheck) async {
    await db.update(
      'list_To_do_Table',
      {'checks': newCheck},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delelteIem(int id) async {
    await db.delete(
      'list_To_do_Table',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Deleted succesfuly');
  }

  Future<List<Map>> getItemValueById(int id) async {
    List<Map> result = await db.query(
      'list_To_do_Table',
      where: 'pro_id = ?',
      whereArgs: [id],
    );

    return result;
  }

  Future<List<Map>> getItemValue(int id, String pattern) async {
    List<Map> result = await db.rawQuery('''
    SELECT * FROM list_To_do_Table
    WHERE pro_id = $id OR items LIKE '%$pattern%'
  ''');

    return result;
  }
}
