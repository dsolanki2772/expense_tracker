import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  static const String dbName = "expenses.db";
  static const int dbVersion = 1;
  static const String tableName = "expenses";
  static const String id = "id";
  static const String description = "description";
  static const String amount = "amount";
  static const String date = "date";

  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName($id INTEGER PRIMARY KEY, $description TEXT, $amount REAL, $date TEXT)',
        );
      },
      version: 1,
    );
  }
}