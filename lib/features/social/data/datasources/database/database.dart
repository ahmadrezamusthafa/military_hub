import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const _dbVersion = 1;

//region create tables query
const userTableName = 'msUser';

const _createTableUser = ''' 
    CREATE TABLE ''' +
    userTableName +
    ''' (
        userId varchar PRIMARY KEY,
        email varchar,
        password varchar,
        name varchar,
        gender varchar,
        address varchar,
        phoneNumber varchar,
        birthDate varchar,
        education varchar,
        occupation varchar,
        profileStatus varchar,
        profilePicture varchar,
        apiToken varchar,
        createdAt text,
        updatedAt text,
        syncedAt text
      )
      ''';
//endregion

Future<Database> initDb() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path + 'militaryhub.db';
  var militaryHubDatabase = openDatabase(
    path,
    version: _dbVersion,
    onCreate: _createDb,
  );
  return militaryHubDatabase;
}

void _createDb(Database db, int version) async {
  await db.execute(_createTableUser);
}
