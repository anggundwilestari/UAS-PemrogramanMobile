import 'package:sqflite/sqflite.dart';
import 'package:uas_43a87006190362/model/food.dart';
import 'package:uas_43a87006190362/provider/sqliteprovider.dart';

class FoodDataAccess {
  Future<List<Food>> getAll() async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Food");
    List<Food> list = response.map((e) => Food.fromMap(e)).toList();
    return list;
  }

  Future<Food?> getById(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.query("Food", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Food.fromMap(response.first) : null;
  }

  insert(Food food) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.insert("Food", food.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return response;
  }

  update(Food food) async {
    final db = await DatabaseProvider.db.database;
    var response = await db
        .update("Food", food.toMap(), where: "id = ?", whereArgs: [food.id]);
    return response;
  }

  deleteById(int id) async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Food", where: "id = ?", whereArgs: [id]);
    return response;
  }

  deleteAll() async {
    final db = await DatabaseProvider.db.database;
    var response = await db.delete("Food");
    return response;
  }
}
