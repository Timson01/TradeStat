import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/deal.dart';
import '../models/image_path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    //if (_database != null) return _database!;

    _database = await _initDB('trade_stat.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE deal_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tickerName TEXT NOT NULL,
    description TEXT NOT NULL,
    dateCreated BIGINT NOT NULL,
    hashtag TEXT NOT NULL,
    amount DOUBLE NOT NULL,
    numberOfStocks INT NOT NULL
    )
    ''');
    batch.execute('''
    CREATE TABLE deal_images_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    imagePath TEXT NOT NULL,
    deal_id INTEGER,
    FOREIGN KEY (deal_id) REFERENCES deal_table (id)
    )
    ''');
    List<dynamic> res = await batch.commit();
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    /*if(oldVersion < newVersion){
      Batch batch = db.batch();
      batch.execute("DROP TABLE IF EXISTS deal_images_table");
      batch.execute('''
    CREATE TABLE deal_images_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    imagePath TEXT NOT NULL,
    deal_id INTEGER,
    FOREIGN KEY (deal_id) REFERENCES deal_table (id)
    )
    ''');
      List<dynamic> res = await batch.commit();
    }*/
  }

  Future<Deal> createDeal(Deal deal) async {
    final db = await instance.database;
    final id = await db.insert(dealTable, deal.toMap());
    return deal.copyWith(id: id);
  }

  Future<List<Deal>> readAllDeals() async {
    final db = await instance.database;
    const orderBy = '${dealFields.dateCreated} ASC';
    final result = await db.query(dealTable, orderBy: orderBy);

    return result.map((e) => Deal.fromMap(e)).toList();
  }

  Future<int> update({required Deal deal}) async {
    final db = await instance.database;

    return db.update(
      dealTable,
      deal.toMap(),
      where: '${dealFields.id} = ?',
      whereArgs: [deal.id],
    );
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      dealTable,
      where: '${dealFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<DealImage> addImage(DealImage imagePath) async {
    final db = await instance.database;
    final id = await db.insert(dealImagesTable, imagePath.toMap());
    return imagePath.copyWith(id: id);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}
