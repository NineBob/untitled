import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/database/model.dart';
import 'package:untitled/database/Recipes.dart';



class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const _databaseName = 'ProductDb.db';
  static const _databaseVersion = 1;
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory dataDir = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDir.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateTable);
  }

  _onCreateTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Product.tableName} (
        ${Product.colName} TEXT PRIMARY KEY,
        ${Product.colDescription} TEXT NOT NULL,
        ${Product.colPrice} NUMERIC NOT NULL,
        ${Product.colTime} TEXT NOT NULL,
        ${Product.colFavorite} INTEGER NOT NULL,
        ${Product.colunit} TEXT NOT NULL,
        ${Product.colkeep} TEXT NOT NULL,
        ${Product.colhistory} TEXT NOT NULL
      )
   ''');
    await db.execute('''
      CREATE TABLE ${TodoItem.tableName} (
        ${TodoItem.coluserid} INTEGER PRIMARY KEY,
        ${TodoItem.colid} INTEGER NOT NULL,
        ${TodoItem.coltitle} TEXT NOT NULL
      )
   ''');
  }

  Future<int> insertTodoItem(TodoItem todoItem) async {
    Database db = await database;
    return await db.insert(
      TodoItem.tableName,
      todoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update
  Future<int> updateTodoItem(TodoItem todoItem) async {
    Database db = await database;
    return await db.update(TodoItem.tableName, todoItem.toMap(),
        where: '${TodoItem.coluserid}=?', whereArgs: [todoItem.userId]);
  }

  // delete
  Future<int> deleteTodoItem(String name) async {
    Database db = await database;
    return await db.delete(TodoItem.tableName,
        where: '${TodoItem.coluserid}=?', whereArgs: [name]);
  }


  Future<List<TodoItem>> fetchTodoItem() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TodoItem.tableName);
    if (maps.isEmpty) {
      return [];
    } else {
      return List.generate(maps.length, (index) {
        return TodoItem(
          userId: maps[index][TodoItem.coluserid],
          id: maps[index][TodoItem.colid],
          title: maps[index][TodoItem.coltitle] ,
        );
      });
    }
  }
  // Insert
  Future<int> insertProduct(Product product) async {
    Database db = await database;
    return await db.insert(
      Product.tableName,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update
  Future<int> updateProduct(Product product) async {
    Database db = await database;
    return await db.update(Product.tableName, product.toMap(),
        where: '${Product.colName}=?', whereArgs: [product.name]);
  }

  // delete
  Future<int> deleteProduct(String name) async {
    Database db = await database;
    return await db.delete(Product.tableName,
        where: '${Product.colName}=?', whereArgs: [name]);
  }


  Future<List<Product>> fetchProducts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(Product.tableName);
    if (maps.isEmpty) {
      return [];
    } else {
      return List.generate(maps.length, (index) {
        return Product(
          name: maps[index][Product.colName],
          description: maps[index][Product.colDescription],
          price: maps[index][Product.colPrice] + 0.00,
          time: maps[index][Product.colTime],
          favorite: maps[index][Product.colFavorite],
          keep: maps[index][Product.colkeep],
          unit: maps[index][Product.colunit],
          history: maps[index][Product.colhistory],
        );
      });
    }
  }
  Future<List<Product>> Products(String key) async {
    Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
          Product.tableName, where: 'name LIKE ?', whereArgs: ['%$key%']);
      if (maps.isEmpty) {
        final List<Map<String, dynamic>> maps = await db.query(
            Product.tableName, where: 'description LIKE ?', whereArgs: ['$key']);

        if (maps.isEmpty) {
          return [];
        } else {
          return List.generate(maps.length, (index) {
            return Product(
              name: maps[index][Product.colName],
              description: maps[index][Product.colDescription],
              price: maps[index][Product.colPrice] + 0.00,
              time: maps[index][Product.colTime],
              favorite: maps[index][Product.colFavorite],
              keep: maps[index][Product.colkeep],
              unit: maps[index][Product.colunit],
              history: maps[index][Product.colhistory],
            );
          });
        }


      } else {
        return List.generate(maps.length, (index) {
          return Product(
            name: maps[index][Product.colName],
            description: maps[index][Product.colDescription],
            price: maps[index][Product.colPrice] + 0.00,
            time: maps[index][Product.colTime],
            favorite: maps[index][Product.colFavorite],
            keep: maps[index][Product.colkeep],
            unit: maps[index][Product.colunit],
            history: maps[index][Product.colhistory],
          );
        });
      }
  }
  // A method that retrieves all the dogs from the dogs table.
  Future<List<Product>> searchData(String key) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(Product.tableName,where: 'description LIKE ?',whereArgs: ['%$key%']);
    if (maps.isEmpty) {
      return [];
    } else {
      return List.generate(maps.length, (index) {
        return Product(
          name: maps[index][Product.colName],
          description: maps[index][Product.colDescription],
          price: maps[index][Product.colPrice] + 0.00,
          time: maps[index][Product.colTime],
          favorite: maps[index][Product.colFavorite],
          keep: maps[index][Product.colkeep],
          unit: maps[index][Product.colunit],
          history: maps[index][Product.colhistory],
        );
      });
    }
  }

}
