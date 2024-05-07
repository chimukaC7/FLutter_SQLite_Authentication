
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqlite_auth_app/model/user.dart';

class DatabaseHelper{

  final databaseName = "auth.db";

  //Tables

  //Don't put a comma at the end of a column in sqlite

  String tableUsers = '''
   CREATE TABLE users (
   usrId INTEGER PRIMARY KEY AUTOINCREMENT,
   fullName TEXT,
   email TEXT,
   usrName TEXT UNIQUE,
   usrPassword TEXT
   )
   ''';

  //Our connection is ready
  Future<Database> initDB ()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path,version: 1 , onCreate: (db,version)async{
      await db.execute(tableUsers);
    });
  }

  //Function methods

  //Authentication
  Future<bool> authenticate(User user)async{
    final Database db = await initDB();
    var result = await db.rawQuery("select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.password}' ");
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  //Sign up
  Future<int> createUser(User user)async{
    final Database db = await initDB();
    return db.insert("users", user.toMap());
  }


  //Get current User details
  Future<User?> getUser(String usrName)async{
    final Database db = await initDB();
    var res = await db.query("users",where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty? User.fromMap(res.first):null;
  }




}