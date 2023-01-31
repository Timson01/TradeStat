import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trade_stat/models/rule.dart';

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
    position TEXT NOT NULL,
    amount DOUBLE NOT NULL,
    income DOUBLE NOT NULL,
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
    batch.execute('''
    CREATE TABLE rule_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ruleName TEXT NOT NULL,
    description TEXT NOT NULL,
    ruleColor INTEGER NOT NULL
    )
    ''');
    await batch.commit();
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
  
  Future<List<Deal>> readDealsWithDate(int startDate, int endDate) async {
    final db = await instance.database;
    final res = await db.rawQuery('''SELECT * FROM deal_table WHERE dateCreated BETWEEN $startDate AND $endDate ORDER BY dateCreated DESC''');
    List<Deal> list =
    res.isNotEmpty ? res.map((c) => Deal.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Deal>> readPositiveDeals(int startDate, int endDate) async {
    final db = await instance.database;
    final res = await db.rawQuery('''SELECT * FROM deal_table WHERE income >= 0 AND dateCreated BETWEEN $startDate AND $endDate ORDER BY dateCreated DESC''');
    List<Deal> list =
    res.isNotEmpty ? res.map((c) => Deal.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Deal>> readDealsByPosition(int startDate, int endDate, String position) async {
    final db = await instance.database;
    final res = await db.rawQuery('''SELECT * FROM deal_table WHERE position LIKE '%$position%' AND dateCreated BETWEEN $startDate AND $endDate ORDER BY dateCreated DESC''');
    List<Deal> list =
    res.isNotEmpty ? res.map((c) => Deal.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Deal>> readNegativeDeals(int startDate, int endDate) async {
    final db = await instance.database;
    final res = await db.rawQuery('''SELECT * FROM deal_table WHERE income < 0 AND dateCreated BETWEEN $startDate AND $endDate ORDER BY dateCreated DESC''');
    List<Deal> list =
    res.isNotEmpty ? res.map((c) => Deal.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Deal>> readAllDeals() async {
    final db = await instance.database;
    const orderBy = '${dealFields.dateCreated} DESC';
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

  Future<int> updateDealDeletedHashtag({required String hashtag}) async {
    final db = await instance.database;

    return await db.rawUpdate(
      ''' UPDATE deal_table SET hashtag = '' WHERE hashtag LIKE '%$hashtag%' '''
    );
  }

  // ------- DEAL IMAGE SECTION ----------

  Future<DealImage> addImage(DealImage imagePath) async {
    final db = await instance.database;
    final id = await db.insert(dealImagesTable, imagePath.toMap());
    return imagePath.copyWith(id: id);
  }

  Future<int> deleteImage({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      dealImagesTable,
      where: '${dealFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<DealImage>> getImagePaths(int dealId) async {
    final db = await instance.database;
    final res = await db.rawQuery('''SELECT * FROM $dealImagesTable WHERE deal_id = $dealId''');
    List<DealImage> imagePaths = res.isNotEmpty ? res.map((c) => DealImage.fromMap(c)).toList() : [];
    return imagePaths;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // ------- RULE SECTION ----------

  Future<Rule> createRule(Rule rule) async {
    final db = await instance.database;
    final id = await db.insert(ruleTable, rule.toMap());
    return rule.copyWith(id: id);
  }

  Future<List<Rule>> readAllRules() async {
    final db = await instance.database;
    const orderBy = '${RuleFields.id} DESC';
    final result = await db.query(ruleTable, orderBy: orderBy);

    return result.map((e) => Rule.fromMap(e)).toList();
  }

  Future<int> updateRule({required Rule rule}) async {
    final db = await instance.database;

    return db.update(
      ruleTable,
      rule.toMap(),
      where: '${RuleFields.id} = ?',
      whereArgs: [rule.id],
    );
  }

  Future<int> deleteRule({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      ruleTable,
      where: '${RuleFields.id} = ?',
      whereArgs: [id],
    );
  }

}
