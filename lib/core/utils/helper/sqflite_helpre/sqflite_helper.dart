import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// ===== SQLITE HELPER CLASS =====
class SQLiteHelper {
  static SQLiteHelper? _instance;
  static Database? _database;

  // Singleton pattern
  SQLiteHelper._internal();

  static SQLiteHelper get instance {
    _instance ??= SQLiteHelper._internal();
    return _instance!;
  }

  // Database configuration
  static const String _databaseName = 'app_database.db';
  static const int _databaseVersion = 1;

  // Get database instance
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // ===== DATABASE INITIALIZATION =====
  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create database tables
  Future<void> _onCreate(Database db, int version) async {
    // Example table - customize as needed
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT,
        age INTEGER,
        created_at TEXT NOT NULL
      )
    ''');

    debugPrint(' Database tables created');
  }

  // ===== BASIC CRUD OPERATIONS =====

  /// إدراج سجل واحد
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    data['created_at'] = DateTime.now().toIso8601String();

    return await db.insert(table, data);
  }

  /// إدراج عدة سجلات
  Future<List<int>> insertBatch(
      String table, List<Map<String, dynamic>> dataList) async {
    final db = await database;
    final batch = db.batch();

    for (var data in dataList) {
      data['created_at'] = DateTime.now().toIso8601String();
      batch.insert(table, data);
    }

    final results = await batch.commit();
    return results.cast<int>();
  }

  /// تحديث السجلات
  Future<int> update(String table, Map<String, dynamic> data,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  /// تحديث بالـ ID
  Future<int> updateById(
      String table, int id, Map<String, dynamic> data) async {
    return await update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  /// حذف السجلات
  Future<int> delete(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  /// حذف بالـ ID
  Future<int> deleteById(String table, int id) async {
    return await delete(table, where: 'id = ?', whereArgs: [id]);
  }

  /// استعلام السجلات
  Future<List<Map<String, dynamic>>> select(
    String table, {
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await database;
    return await db.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  /// البحث عن سجل بالـ ID
  Future<Map<String, dynamic>?> findById(String table, int id) async {
    final results =
        await select(table, where: 'id = ?', whereArgs: [id], limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  /// عدد السجلات
  Future<int> count(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $table${where != null ? ' WHERE $where' : ''}',
      whereArgs,
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// تنفيذ استعلام SQL خام
  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  /// حذف جميع البيانات من الجدول
  Future<void> clearTable(String table) async {
    await delete(table);
  }

  /// إغلاق قاعدة البيانات
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
