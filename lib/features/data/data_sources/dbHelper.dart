import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:finance/features/data/models/particular_transaction_model.dart';
import 'dart:io' as io;
import 'dart:async';


class DbHelper {
  static Database? _db;

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    else{
      _db = await initDatabase();
      return _db;
    }
  }
  // INITIALIZE DATABASE
  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'finance.db');
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    // var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }
  // CREATE DATABASE
  _onCreate (Database db, int version) async{
    await db.execute(
      '''CREATE TABLE particular_transaction (id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER NOT NULL, date TEXT NOT NULL, amount REAL NOT NULL, balance REAL NOT NULL, payer TEXT)''',
    );
    await db.execute(
      '''CREATE TABLE date_wise_transactions (id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER NOT NULL, date TEXT NOT NULL, debit REAL NOT NULL, credit REAL NOT NULL, balance REAL NOT NULL)''',
    );
    await db.execute(
        '''CREATE TABLE financial_report (id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER NOT NULL, total_debit REAL NOT NULL, total_credit REAL NOT NULL)''',
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // if (oldVersion < 7) {
    //   final result = await db.rawQuery(
    //     "PRAGMA table_info(products)",
    //   );
    //   final existingColumns = result.map((e) => e['name']).toList();
    //
    //   if (!existingColumns.contains('description')) {
    //     db.execute('ALTER TABLE products ADD COLUMN description TEXT');
    //   }
    //   // Check if 'batch' column doesn't exist in 'products' table
    //   if (!existingColumns.contains('batch')) {
    //     db.execute('ALTER TABLE products ADD COLUMN batch TEXT');
    //   }
    // }
  }
  // INSERT DATA: insert individual-transaction data into database
  Future<ParticularTransactionModel> insertIndividualTransaction(ParticularTransactionModel particularTransactionModel) async{
    try {
      var dbClint = await db;
      await dbClint!.insert('particular_transaction', particularTransactionModel.toJson());
    }
    catch(error){
      if (error is DatabaseException) {
        print('database error');
      } else {
        print('other exception');
        // Handle other errors here.
      }
    }
    print(particularTransactionModel.toJson());
    return particularTransactionModel;
  }

  // QUERY DATA: query DB to get data
  Future<List<ParticularTransactionModel>> getParticularTransactionList () async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('particular_transaction');
    return queryResult.map((Map<String, dynamic> map) => ParticularTransactionModel.fromJson(map)).toList();
  }

  // Future<int> updateProduct(ProductModel updatedProduct) async{
  //   try {
  //     var dbClient = await db;
  //     return await dbClient!.update(
  //       'finance',
  //       updatedProduct.toJson(),
  //       where: 'id = ?',
  //       whereArgs: [updatedProduct.id],
  //     );
  //   } catch (error) {
  //     if (error is DatabaseException) {
  //       return -1; // Return an error code or handle the error as needed.
  //     } else {
  //       return -1; // Return an error code or handle the error as needed.
  //     }
  //   }
  // }
  //
  // DELETE DATA: query database according to id and delete Individual-transaction data
  Future<int> deleteIndividualTransaction(int id) async{
    var dbClient = await db;
    return await dbClient!.delete('particular_transaction', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ParticularTransactionModel>> queryItemsBetweenDates(String startDate, String endDate) async {
    // print('Query Start $startDate');
    // print('Query end $endDate');
    final dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'particular_transaction',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date ASC', // Change to 'date DESC' for descending order
    );
    return queryResult.map((Map<String, dynamic> map) => ParticularTransactionModel.fromJson(map)).toList();
  }

  // // BACKUP DATABASE
  // backupDB() async{
  //   // var status = await Permission.manageExternalStorage.status;
  //   var status = await Permission.storage.status;
  //   print(status);
  //   if (!status.isGranted){
  //     await Permission.manageExternalStorage.request();
  //   }
  //   var status1 = await Permission.storage.status;
  //
  //   if(!status1.isGranted){
  //     await Permission.storage.request();
  //   }
  //   try {
  //     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  //     print(documentDirectory.path);
  //     String path = join(documentDirectory.path, 'finance.db');
  //     io.File ourDBFile = io.File( path);
  //     io.Directory ? folderPathForDBFile = io.Directory("/storage/emulated/0/FinanceDatabase/");
  //     await folderPathForDBFile.create();
  //     await ourDBFile.copy("/storage/emulated/0/FinanceDatabase/finance.db");
  //   }
  //   catch(e){
  //     print("DB Backup Error: ${e.toString()}");
  //   }
  // }
  //
  // restoreDB() async{
  //   var status = await Permission.manageExternalStorage.status;
  //   if (!status.isGranted){
  //     await Permission.manageExternalStorage.request();
  //   }
  //   var status1 = await Permission.storage.status;
  //
  //   if(!status1.isGranted){
  //     await Permission.storage.request();
  //   }
  //   try{
  //     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  //     String path = join(documentDirectory.path, 'finance.db');
  //     io.File saveDBFile = io.File(
  //         "/storage/emulated/0/FinanceDatabase/finance.db"
  //     );
  //     await saveDBFile.copy(path);
  //   }
  //   catch(e){
  //     print("DB Restore Error: ${e.toString()}");
  //   }
  // }
  //
  // deleteDB() async {
  //   try {
  //     _db = null;
  //     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  //     String path = join(documentDirectory.path, 'finance.db');
  //     deleteDatabase(path);
  //   }
  //   catch(e){
  //     print("DB Delete Error: ${e.toString()}");
  //   }
  // }
  //
  // getStoragePath() async{
  //   String databasePath = await getDatabasesPath();
  //   print("============ $databasePath");
  //   io.Directory ? externalStoragePath = await getExternalStorageDirectory();
  //   print("============ $externalStoragePath");
  // }

}
