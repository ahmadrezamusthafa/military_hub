import 'package:military_hub/features/social/data/models/database/user_db_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class UserDbRepository {
  Future<int> insert(UserDbModel model) async {
    Database db = await initDb();
    int count = await db.insert(
      userTableName,
      model.toMap(),
    );
    return count;
  }

  Future<int> update(UserDbModel model) async {
    Database db = await initDb();
    int count = await db.update(
      userTableName,
      model.toMap(),
      where: 'userId=?',
      whereArgs: [model.userId],
    );
    return count;
  }

  Future<int> delete(UserDbModel model) async {
    Database db = await initDb();
    int count = await db.delete(
      userTableName,
      where: 'userId=?',
      whereArgs: [model.userId],
    );
    return count;
  }

  Future<int> deleteAll() async {
    Database db = await initDb();
    int count = await db.delete(userTableName);
    return count;
  }

  Future<UserDbModel> getUser() async {
    Database db = await initDb();
    List<Map<String, dynamic>> mapList = await db.query(
      userTableName,
      orderBy: 'name',
    );
    int count = mapList.length;
    if (count > 0) {
      return UserDbModel.fromMap(mapList[0]);
    }
    return null;
  }
}
