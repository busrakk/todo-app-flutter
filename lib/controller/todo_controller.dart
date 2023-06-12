import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoController extends GetxController {
  List<Todo> todoList = []; // bütün todoları veritabanından çekme
  late Database database;
  final String dbName = "todo.db";

  // database yoksa oluşturulsun varsa açılsın
  @override
  void onInit() async {
    await createDatabase();
    super.onInit();
  }

  Future<void> createDatabase() async {
    // sqflite paketi default olarak veritabanını hangi pathe oluşturuyor
    var defaultDBPath = await getDatabasesPath();

    final actualDBPath = join(defaultDBPath, dbName);
    openDatabase(actualDBPath);
  }

  Future<void> openAppDatabase({required String path}) async {
    // gönderilen path içinde database yoksa sıfırdan oluşturup açar, varsa direk açar.
    await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, description TEXT, time TEXT, favorite INTEGER, completed INTEGER)"); // tablo oluşturma
        debugPrint("database created");
      },
      onOpen: (db) async {
        database = db;
        await getAllTodos(); // uygulama açılınca tüm dataları çekme
        debugPrint("database opened");
      },
    );
  }

// database delete
  Future<void> deleteTheDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    await deleteDatabase(path);
    debugPrint("$dbName has been deleted");
  }

  Future<void> getAllTodos() async {
    var allData =
        await database.query("todo"); // tablodaki tüm kayıtları getirir
    todoList = allData.map((record) => Todo.fromJSON(record)).toList();

    todoList.forEach(print); // todo listesindeki her bir elemanı yazdır
    update(); // getbuilder yapısını kullanılacağı için
  }

  Future<void> insertTodo(Todo todo) async {
    var insert = await database.insert("todo", {
      "title": todo.title,
      "description": todo.description,
      "time": todo.time,
      "favorite": todo.favorite,
      "completed": todo.completed
    });
    debugPrint("$insert data was inserted");
    // todoList.add(todo);
    // update();
    getAllTodos();
  }

  Future<void> updateTodo(int id, Todo updatedTodo) async {
    var count = await database.update(
        "todo",
        {
          "title": updatedTodo.title,
          "description": updatedTodo.description,
          "time": updatedTodo.time,
          "favorite": updatedTodo.favorite,
          "completed": updatedTodo.completed
        },
        where: "id=$id");
    debugPrint("Updated row count: $count");
    getAllTodos();
  }

  Future<void> deleteTodo(int id) async {
    var count = await database.delete("todo", where: "id=$id");
    debugPrint("Deleted row count: $count");
  }
}
