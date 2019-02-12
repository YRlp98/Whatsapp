import 'package:sqflite/sqflite.dart';
import 'package:whatsapp/models/user.dart';
import 'package:whatsapp/sqlliteProvider/provider.dart';

class UserProvider extends Provider {
  String _tableName = 'users';

  Future<bool> insert(User user,
      {conflictAlgorithm: ConflictAlgorithm.replace}) async {
    await db.insert(_tableName, user.toMap(),
        conflictAlgorithm: conflictAlgorithm);
    return true;
  }

  Future<User> getUser(int id) async {
    List<Map> maps = await db.query(_tableName,
        columns: ['id', 'api_token'], where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return User.fromJson(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    return await db.update(_tableName, user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }
}
