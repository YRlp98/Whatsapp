import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Provider {
  Database db;
  String _path;

  Future open({String dbName: 'roocket.db'}) async {
    var databasesPath = await getDatabasesPath();
    _path = join(databasesPath, dbName);

    db = await openDatabase(_path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table products ( 
          id integer primary key autoincrement,
          user_id integer not null, 
          title text not null,
          body text not null,
          image text not null,
          price text not null,
          created_at text not null,
          updated_at text not null)
          ''');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute('''
        create table products ( 
          id integer primary key autoincrement,
          api_token text not null)
          ''');
    });
  }

  Future close() async => db.close();
}
