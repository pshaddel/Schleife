import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        monday INTEGER,
        tuesday INTEGER,
        wednesday INTEGER,
        thursday INTEGER,
        friday INTEGER,
        saturday INTEGER,
        sunday INTEGER,
        color TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a Task
// title, description: name and description of your activity
// created_at: the time that the Task was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'schleife2.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new Task (journal)
  static Future<int> createTask(
      String title, String color, List<bool> weekdays) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'color': color,
      'monday': weekdays[0] ? 1 : 0,
      'tuesday': weekdays[1] ? 1 : 0,
      'wednesday': weekdays[2] ? 1 : 0,
      'thursday': weekdays[3] ? 1 : 0,
      'friday': weekdays[4] ? 1 : 0,
      'saturday': weekdays[5] ? 1 : 0,
      'sunday': weekdays[6] ? 1 : 0,
    };
    final id = await db.insert('Tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all Tasks (journals)
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await SQLHelper.db();
    return db.query('Tasks', orderBy: "id");
  }

  // Read a single Task by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getTask(int id) async {
    final db = await SQLHelper.db();
    return db.query('Tasks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an Task by id
  static Future<int> updateTask(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('Tasks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteTask(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Tasks", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Task: $err");
    }
  }
}