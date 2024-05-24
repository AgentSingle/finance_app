import 'dart:ffi';

import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:finance/features/data/models/particular_transaction_model.dart';
import 'package:finance/features/data/models/date_wise_transaction_model.dart';
import 'package:finance/features/data/models/financial_report_model.dart';
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

  /* ---------------------------------------------------------------------------
  CREATE DATABASE
  ------------------------------------------------------------------------------ */
  _onCreate (Database db, int version) async{
    await db.execute(
      '''CREATE TABLE particular_transaction (id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER NOT NULL, date TEXT NOT NULL, amount REAL NOT NULL, payer TEXT)''',
    );
    await db.execute(
      '''CREATE TABLE date_wise_transactions (id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER NOT NULL, date TEXT NOT NULL, debit REAL NOT NULL, credit REAL NOT NULL, balance REAL NOT NULL)''',
    );
    await db.execute(
        '''CREATE TABLE financial_report (id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER NOT NULL, debit REAL NOT NULL, credit REAL NOT NULL)''',
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

/* ========================[APPLY FOR particular_transaction TABLE ]======================== */

  /* ---------------------------------------------
  INSERT DATA: insert individual-transaction data
  ------------------------------------------------ */
  /* INSERT DATA: insert individual-transaction data into database */
  Future<ParticularTransactionModel> insertIndividualTransaction(ParticularTransactionModel particularTransactionModel) async{

    // Query last item of date-wise-transaction table
    Map<String, dynamic> data = particularTransactionModel.toJson();
    String date = data['date'].toString();
    List<DateWiseTransactionModel> lastDateWiseTransaction = await queryDateWiseItemsBetweenDates(date, date);
    List<FinancialReportModel> financialYearReport = await queryFinancialReport(data['year']);

    if (lastDateWiseTransaction.isEmpty){
      insertDateWiseTransaction(
        DateWiseTransactionModel(
          year: data['year'],
          date: data['date'],
          debit: (data['amount']>=0)?data['amount']:0,
          credit: (data['amount']<0)?data['amount']:0,
          balance: data['amount'],
        )
      ).then((value) => null).onError((error, stackTrace) => null);
    }
    else{
      DateWiseTransactionModel existedItem = lastDateWiseTransaction.first;
      double newDebt = (data['amount']>=0)?data['amount']:0.0;
      double newCredit = (data['amount']<0)?data['amount']:0.0;
      DateWiseTransactionModel updateTo = DateWiseTransactionModel(
        id: existedItem.id,
        year: existedItem.year,
        date: existedItem.date,
        debit: existedItem.debit + newDebt,
        credit: existedItem.credit + newCredit,
        balance: existedItem.balance + data['amount'],
      );
      updateDateWiseTransaction(updateTo)
      .then((value) => null)
      .onError((error, stackTrace) => null);
    }

    if (financialYearReport.isEmpty){
      insertFinancialReport(
        FinancialReportModel(
          year: data['year'],
          debit: (data['amount']>=0)?data['amount']:0,
          credit: (data['amount']<0)?data['amount']:0,
        )
      ).then((value) => null).onError((error, stackTrace) => null);
    }
    else{
      FinancialReportModel existedItem = financialYearReport.first;
      double newDebt = (data['amount']>=0)?data['amount']:0.0;
      double newCredit = (data['amount']<0)?data['amount']:0.0;
      FinancialReportModel updateTo = FinancialReportModel(
        id: existedItem.id,
        year: existedItem.year,
        debit: existedItem.debit + newDebt,
        credit: existedItem.credit + newCredit,
      );
      updateFinancialReport(
          updateTo
      ).then((value) => null).onError((error, stackTrace) => null);
    }


    try {
      var dbClint = await db;
      await dbClint!.insert('particular_transaction', data);
    }
    catch(error){
      if (error is DatabaseException) {
        print('database error');
      } else {
        print('other exception');
        // Handle other errors here.
      }
    }
    return particularTransactionModel;
  }

  /* ----------------------------------------------------------------
  QUERY DATA: query DB to get data from particular transaction table
  ------------------------------------------------------------------- */
  Future<List<ParticularTransactionModel>> getParticularTransactionList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('particular_transaction');
    return queryResult.map((Map<String, dynamic> map) => ParticularTransactionModel.fromJson(map)).toList();
  }

  /* ---------------------------------------------------------------------------------
  QUERY DATA: According to date here we filter data from particular transaction table
  -------------------------------------------------- --------------------------------- */
  Future<List<ParticularTransactionModel>> queryItemsBetweenDates(String startDate, String endDate) async {
    final dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'particular_transaction',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date ASC', // Change to 'date DESC' for descending order
    );
    return queryResult.map((Map<String, dynamic> map) => ParticularTransactionModel.fromJson(map)).toList();
  }

  /* ------------------------------------------
  UPDATE DATA: in particular transaction table
  --------------------------------------------- */
  // Future<int> updateIndividualTransaction(ParticularTransactionModel updatedTransaction) async{
  //   try {
  //     var dbClient = await db;
  //     return await dbClient!.update(
  //       'particular_transaction',
  //       updatedTransaction.toJson(),
  //       where: 'id = ?',
  //       whereArgs: [updatedTransaction.id],
  //     );
  //   } catch (error) {
  //     if (error is DatabaseException) {
  //       return -1; // Return an error code or handle the error as needed.
  //     } else {
  //       return -1; // Return an error code or handle the error as needed.
  //     }
  //   }
  // }


  /* --------------------------------------------------------------------------------
  DELETE DATA: query database according to id and delete Individual-transaction data
  ----------------------------------------------------------------------------------- */
  Future<int> deleteIndividualTransaction(int id, int year, String date, double amount) async{
    var dbClient = await db;

    List<DateWiseTransactionModel> lastDateWiseTransaction = await queryDateWiseItemsBetweenDates(date, date);
    List<FinancialReportModel> financialYearReport = await queryFinancialReport(year);
    DateWiseTransactionModel existedItem = lastDateWiseTransaction.first;
    FinancialReportModel existedReportItem = financialYearReport.first;
    double newDebt = (amount>=0)?amount:0.0;
    double newCredit = (amount<0)?amount:0.0;

    // FOR DATE-WISE TRANSACTIONAL TABLE
    double dDebit = existedItem.debit - newDebt;
    double dCredit = existedItem.credit - newCredit;
    double dBalance = existedItem.balance - amount;

    if(dDebit==0 && dCredit ==0 && dBalance==0){
      deleteDateWiseTransaction(existedItem.id!);
    }
    else{
      DateWiseTransactionModel dateWiseTransactionUpdateTo = await DateWiseTransactionModel(
        id: existedItem.id,
        year: existedItem.year,
        date: existedItem.date,
        debit: existedItem.debit - newDebt,
        credit: existedItem.credit - newCredit,
        balance: existedItem.balance - amount,
      );
      updateDateWiseTransaction(
          dateWiseTransactionUpdateTo
      ).then((value) => null).onError((error, stackTrace) => null);
    }

    // FOR FINANCIAL TABLE
    double fiDebit = existedReportItem.debit - newDebt;
    double fiCredit = existedReportItem.credit - newCredit;
    if(fiCredit==0 && fiDebit ==0){
      deleteFinancialReport(existedReportItem.year);
    }
    else{
      FinancialReportModel financialReportUpdateTo = await FinancialReportModel(
        id: existedReportItem.id,
        year: existedReportItem.year,
        debit: existedReportItem.debit - newDebt,
        credit: existedReportItem.credit - newCredit,
      );
      updateFinancialReport(
          financialReportUpdateTo
      ).then((value) => null).onError((error, stackTrace) => null);
    }

    return await dbClient!.delete('particular_transaction', where: 'id = ?', whereArgs: [id]);
  }


/* ========================[APPLY FOR date_wise_transaction TABLE ]======================== */

  /* ---------------------------------------------
  INSERT DATA: insert date-wise-transaction data
  ------------------------------------------------ */
  /* INSERT DATA: insert individual-transaction data into database */
  Future<DateWiseTransactionModel> insertDateWiseTransaction(DateWiseTransactionModel dateWiseTransactionModel) async{
    try {
      var dbClint = await db;
      await dbClint!.insert('date_wise_transactions', dateWiseTransactionModel.toJson());
    }
    catch(error){
      if (error is DatabaseException) {
        print('database error in date wise table');
      } else {
        print('other exception');
        // Handle other errors here.
      }
    }
    print('helloworld');
    return dateWiseTransactionModel;
  }

  /* ---------------------------------------------------------------------------------
  QUERY DATA: According to date here we filter data from particular transaction table
  -------------------------------------------------- --------------------------------- */
  Future<List<DateWiseTransactionModel>> queryDateWiseItemsBetweenDates(String startDate, String endDate) async {
    final dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'date_wise_transactions',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date ASC', // Change to 'date DESC' for descending order
    );
    return queryResult.map((Map<String, dynamic> map) => DateWiseTransactionModel.fromJson(map)).toList();
  }

  /* ------------------------------------------
  UPDATE DATA: in particular transaction table
  --------------------------------------------- */
  Future<int> updateDateWiseTransaction(DateWiseTransactionModel updatedTransaction) async{
    try {
      var dbClient = await db;
      return await dbClient!.update(
        'date_wise_transactions',
        updatedTransaction.toJson(),
        where: 'id = ?',
        whereArgs: [updatedTransaction.id],
      );
    } catch (error) {
      if (error is DatabaseException) {
        return -1; // Return an error code or handle the error as needed.
      } else {
        return -1; // Return an error code or handle the error as needed.
      }
    }
  }

  /* ------------------------------------------
  DELETE DATA: in particular transaction table
  --------------------------------------------- */
  Future<int> deleteDateWiseTransaction(int id) async{
    var dbClient = await db;
    return await dbClient!.delete('date_wise_transactions', where: 'id = ?', whereArgs: [id]);
  }


/* ========================[APPLY FOR financial_report TABLE ]======================== */

  /* ---------------------------------------------
  INSERT DATA: insert financial_report data
  ------------------------------------------------ */
  /* INSERT DATA: insert individual-transaction data into database */
  Future<FinancialReportModel> insertFinancialReport(FinancialReportModel financialReportModel) async{
    try {
      var dbClint = await db;
      await dbClint!.insert('financial_report', financialReportModel.toJson());
    }
    catch(error){
      if (error is DatabaseException) {
        print('database error in financial report table');
      } else {
        print('other exception');
        // Handle other errors here.
      }
    }
    return financialReportModel;
  }

  /* ------------------------------------------
  UPDATE DATA: financial-report table
  --------------------------------------------- */
  Future<int> updateFinancialReport(FinancialReportModel updatedReportModel) async {
    try {
      var dbClient = await db;
      return await dbClient!.update(
        'financial_report',
        updatedReportModel.toJson(),
        where: 'id = ?',
        whereArgs: [updatedReportModel.id],
      );
    } catch (error) {
      if (error is DatabaseException) {
        return -1; // Return an error code or handle the error as needed.
      } else {
        return -1; // Return an error code or handle the error as needed.
      }
    }
  }

  /* ---------------------------------------------------------------------------------
  QUERY DATA: According to date here we filter data from financial report
  -------------------------------------------------- --------------------------------- */
  Future<List<FinancialReportModel>> queryFinancialReport(int year) async {
    final dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'financial_report',
      where: 'year = ?',
      whereArgs: [year],
      orderBy: 'id DESC', // Change to 'date DESC' for descending order
    );
    return queryResult.map((Map<String, dynamic> map) => FinancialReportModel.fromJson(map)).toList();
  }

  /* ---------------------------------------------------------------------------------
  QUERY DATA: According to date here we filter data from particular transaction table
  -------------------------------------------------- --------------------------------- */
  Future<List<FinancialReportModel>> queryFinancialReportBetweenYears(int startYear, int endYear) async {
    final dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'financial_report',
      where: 'year BETWEEN ? AND ?',
      whereArgs: [startYear, endYear],
      orderBy: 'year DESC', // Change to 'date DESC' for descending order
    );
    return queryResult.map((Map<String, dynamic> map) => FinancialReportModel.fromJson(map)).toList();
  }

  Future<int> deleteFinancialReport(int year) async{
    var dbClient = await db;
    return await dbClient!.delete('financial_report', where: 'year = ?', whereArgs: [year]);
  }


/* ========================[ APPLY FOR ALL TABLE ]======================== */
  /* QUERY DATA: Get Last Item From a Table */
  Future<Map<String, dynamic>?> getLastItem(String tableName) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> queryResult = await dbClient!.query(
      tableName,
      orderBy: 'id DESC',
      limit: 1,
    );
    if (queryResult.isNotEmpty) {
      return queryResult.first;
    }
    return null;
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
  deleteDB() async {
    try {
      _db = null;
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'finance.db');
      deleteDatabase(path);
    }
    catch(e){
      print("DB Delete Error: ${e.toString()}");
    }
  }
  //
  // getStoragePath() async{
  //   String databasePath = await getDatabasesPath();
  //   print("============ $databasePath");
  //   io.Directory ? externalStoragePath = await getExternalStorageDirectory();
  //   print("============ $externalStoragePath");
  // }

}
