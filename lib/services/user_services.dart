import 'dart:convert';

import 'package:whatsapp/models/user.dart';
import 'package:whatsapp/sqlliteProvider/user_provider.dart';

class UserService {
  static Future<bool> storeUser(Map<String, dynamic> userData) async {
    var dbUser = new UserProvider();

//    try {
    await dbUser.open();
    await dbUser.insert(User.fromJson(userData));
    await dbUser.close();
    return true;
//    } catch (e) {
//      return false;
//    }
  }

  static Future<User> getUser(int id) async {
    var dbUser = new UserProvider();

    try {
      await dbUser.open();
      User user = await dbUser.getUser(id);
      await dbUser.close();
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future updateUser(User user) async {
    var dbUser = new UserProvider();

    await dbUser.open();
    await dbUser.update(user);
    await dbUser.close();
    return true;
  }

  static Future removeUser(int id) async {
    var dbUser = new UserProvider();

    await dbUser.open();
    await dbUser.delete(id);
    await dbUser.close();
    return true;
  }
}
