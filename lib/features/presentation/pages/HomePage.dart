import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/containers/Home/revenueContainer.dart';
import 'package:finance/features/presentation/widgets/containers/transactionCards.dart';
import 'package:finance/features/presentation/widgets/containers/individualTransactionCard.dart';
import 'package:finance/features/presentation/widgets/containers/containerWithBGI.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/individualTransactionFilter.dart';
import 'package:finance/features/presentation/widgets/popUps/fromDialog.dart';
import 'package:finance/features/presentation/widgets/froms/transactionAddForm.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';

import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/data/models/particular_transaction_model.dart';
import 'package:finance/features/data/models/date_wise_transaction_model.dart';
import 'package:finance/features/data/models/financial_report_model.dart';
import 'package:finance/features/presentation/block/modifyListObject.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int appStartYear = startYear();
  String startDate = convertYyMmDd(getPreviousDate(31));
  String endDate = convertYyMmDd(getPreviousDate(0));
  int year = DateTime.now().year.toInt();

  //DATABASE RELATED JOB
  DbHelper? dbHelper;
  // late Future<List<ParticularTransactionModel>> particularTransactionList;
  late Future<List<PTModelWithBalance>> individualTransactionList = Future.value([]);
  Map<String, dynamic> d1TOd2Transaction = {
    'year': DateTime.now().year.toInt(),
    'date1': convertYyMmDd(getPreviousDate(31)),
    'date2': convertYyMmDd(getPreviousDate(0)),
    'debit': 0,
    'credit': 0,
    'balance': 0,
  };
  Map<String, dynamic> financialReport = {
    'year': DateTime.now().year.toInt(),
    'debit': 0,
    'credit': 0,
  };

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadFinancialReport(year);

    // loadData(startDate, endDate);
    // loaDd1TOd2Transaction(startDate, endDate, year);
  }


  // GET INDIVIDUAL TRANSACTION DATA ACCORDING TO DATE
  loadData(String start, String end) async {
    List<ParticularTransactionModel> data = await dbHelper!.queryItemsBetweenDates(start, end);
    List<Map<String, dynamic>> mapData = (data.map((e) => e.toJson())).toList();
    final List<Map<String, dynamic>> newData = calculateBalance(mapData);
    final modelList = newData.map(convertMapToModel).toList();
    setState(() {
      individualTransactionList = Future.value(modelList);
    });
  }

  loaDd1TOd2Transaction(String start, String end, int year) async{
    List<DateWiseTransactionModel> d1ToD2Transactions = await dbHelper!.queryDateWiseItemsBetweenDates(start, end);
    List<Map<String, dynamic>> mapD1ToD2Transactions = (d1ToD2Transactions.map((e) => e.toJson())).toList();

    List<FinancialReportModel> lastFinancialYearReport = await dbHelper!.queryFinancialReportBetweenYears(appStartYear, year-1);
    List<Map<String, dynamic>> mapLastFinancialYearReport = (lastFinancialYearReport.map((e) => e.toJson())).toList();

    final Map<String, dynamic> newData = ittCalculation(mapD1ToD2Transactions, mapLastFinancialYearReport);
    setState(() {
      d1TOd2Transaction['date1'] = start;
      d1TOd2Transaction['date2'] = end;
      d1TOd2Transaction['balance'] = newData['total'];
      d1TOd2Transaction['debit'] = newData['totalDebit'];
      d1TOd2Transaction['credit'] = newData['totalCredit'];
    });
  }

  // LOAD FINANCIAL TRANSACTION ACCORDING TO YEAR
  loadFinancialReport(year)async{
    List<FinancialReportModel> financialReports = await dbHelper!.queryFinancialReport(year);
    if (financialReports.isNotEmpty){
      setState(() {
        financialReport = financialReports.first.toJson();
      });
    }
  }

  // INSERT INDIVIDUAL TRANSACTION
  void insertTransaction(Map<String, dynamic> data) async {
    dbHelper!.insertIndividualTransaction(
      ParticularTransactionModel(
        year: DateTime.parse(data['date']).year,
        date: data['date'],
        amount: data['amount'],
        payer: null,
      ),
    ).then((value){
      setState(() {
        loadData(startDate, endDate);
        loaDd1TOd2Transaction(startDate, endDate, year);
        loadFinancialReport(year);
      });
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }

  deleteTransaction(Map data) async{
    var resp = await dbHelper!.deleteIndividualTransaction(data['id'], data['year'], data['date'], data['amount']);
    if (resp != null){
      setState(() {
        loadData(startDate, endDate);
        loaDd1TOd2Transaction(startDate, endDate, year);
        loadFinancialReport(year);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueSecondary,
      body: SafeArea(
        child: appBackgroundContainer(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ===========[ ANNUAL-REVENUE CONTAINER ]=============
                revenueContainer(
                  financialData: financialReport,
                ),
                const SizedBox(
                  height: 8,
                ),

                // ===========[ DATE FILTER CONTAINER ]=============
                IndividualTransactionFilter(
                  dropDownList: const ['Range', 'Particular'],
                  filterData: (Map<String, dynamic> data){
                    setState(() {
                      startDate = data['startDate'];
                      endDate = data['endDate'];
                      loadData(data['startDate'], data['endDate']);
                      loaDd1TOd2Transaction(
                          data['startDate'],
                          data['endDate'],
                          DateTime.parse(data['endDate']).year
                      );
                    });
                  }
                ),
                const SizedBox(
                  height: 8,
                ),

                // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
                Container(
                  width: MediaQuery.of(context).size.width - 16,
                  height: MediaQuery.of(context).size.height - 510,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),

                  child: FutureBuilder(
                    future: individualTransactionList,
                    builder: (context, AsyncSnapshot<List<PTModelWithBalance>> snapshot) {
                      if(snapshot.hasData && snapshot.data!.isNotEmpty){
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              // child: Text('${snapshot.data![index].date}'),
                              child: IndividualTransactionCards(
                                index: snapshot.data![index].id?? index,
                                year: snapshot.data![index].year,
                                date: snapshot.data![index].date,
                                amount: snapshot.data![index].amount,
                                balance: snapshot.data![index].balance,
                                actionResponse: (data){
                                  if (data['action'] == 'DELETE'){
                                    deleteTransaction(data);
                                  }
                                },
                              ),
                            );
                          }
                          // ),
                        );
                      }
                      else{
                        return const ContainerWithBGI();
                      }
                    }
                  ),

                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 16,
                  height: 65,
                  child: TransactionCards(
                    cardsData: d1TOd2Transaction,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: const GlobalBottomBar(),
      floatingActionButton: CircularFloatingButton(
        iconData: Icons.add,
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
            return FromDialog(
              height: 300,
              child: TransactionAddingForm(
                height: 350,
                onSave: (Map<String, dynamic> data){
                  // print(data);
                  insertTransaction(data);
                },
              ),
            );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
    );
  }
}



