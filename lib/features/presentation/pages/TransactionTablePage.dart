import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/features/presentation/widgets/containers/containerWithBGI.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/transactionTable/transactionTableRow.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/transactionFilter.dart';
import 'package:finance/features/presentation/widgets/xlsxGen/generateXlsx.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';

import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/data/models/particular_transaction_model.dart';
import 'package:finance/features/data/models/date_wise_transaction_model.dart';
import 'package:finance/features/data/models/financial_report_model.dart';
import 'package:finance/features/presentation/block/modifyListObject.dart';

class TransactionTablePage extends StatefulWidget {
  const TransactionTablePage({super.key});

  @override
  State<TransactionTablePage> createState() => _TransactionTablePageState();
}

class _TransactionTablePageState extends State<TransactionTablePage> {
  int appStartYear = startYear();
  String startDate = convertYyMmDd(getPreviousDate(31));
  String endDate = convertYyMmDd(getPreviousDate(0));

  //DATABASE RELATED JOB
  DbHelper? dbHelper;
  late Future<List<PTModelWithBalance>> individualTransactionList = Future.value([]);
  late List<Map<String, dynamic>> dataForXlsx;
  Map<String, dynamic> d1TOd2Transaction = {
    'debit': 0,
    'credit': 0,
    'balance': 0,
  };

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  // GET INDIVIDUAL TRANSACTION DATA ACCORDING TO DATE
  loadData(String start, String end) async {
    List<ParticularTransactionModel> data = await dbHelper!.queryItemsBetweenDates(start, end);
    List<Map<String, dynamic>> mapData = (data.map((e) => e.toJson())).toList();
    final List<Map<String, dynamic>> newData = calculateBalance(mapData);
    dataForXlsx = newData;
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
      d1TOd2Transaction['balance'] = newData['total'];
      d1TOd2Transaction['debit'] = newData['totalDebit'];
      d1TOd2Transaction['credit'] = newData['totalCredit'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueSecondary,
      body: SafeArea(
        child: appBackgroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ===========[ DATE FILTER CONTAINER ]=============
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TransactionFilter(
                  dropDownList: ['Range', 'Particular'],
                  filterData: (Map<String, dynamic> data){
                    setState(() {
                      loadData(data['startDate'], data['endDate']);
                      loaDd1TOd2Transaction(
                          data['startDate'],
                          data['endDate'],
                          DateTime.parse(data['endDate']).year
                      );
                    });
                  }
              ),
              ),

              // ===========[ Table Header ]=============
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    // color: blueDeep,
                  ),
                ),
                child: const TransactionTableRow(
                  height: 45,
                  date: "Date",
                  debit: "Debit",
                  credit: "Credit",
                  total: "Balance",
                  fontWeight: FontWeight.bold
                ),
              ),

              // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.height - 290,
                child: FutureBuilder(
                  future: individualTransactionList,
                  builder: (context, AsyncSnapshot<List<PTModelWithBalance>> snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width - 16,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  right: BorderSide(
                                    // color: blueDeep,
                                    width: 1.0,
                                  ),
                                  bottom: BorderSide(
                                    // color: blueDeep,
                                    width: 1.0,
                                  ),
                                  left: BorderSide(
                                    // color: blueDeep,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: TransactionTableRow(
                                height: 35,
                                // date: formatDate(getCurrentDate()),
                                date: '${formatDate(convertDdMmYy(snapshot.data![index].date))?? ''}',
                                debit: (snapshot.data![index].amount>=0)? snapshot.data![index].amount.toString():'',
                                credit: (snapshot.data![index].amount<0)? snapshot.data![index].amount.abs().toString():'',
                                total: snapshot.data![index].balance.toString(),
                              ),
                            );
                          }
                      );
                    }
                    else{
                      return ContainerWithBGI();
                    }
                  }
                ),
              ),

              // ===========[ Table Bottom ]=============
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    // color: blueDeep,
                  ),
                ),
                child: TransactionTableRow(
                  height: 45,
                  date: "Total",
                  debit: "${d1TOd2Transaction['debit']}",
                  credit: "${d1TOd2Transaction['credit']}",
                  total: "${d1TOd2Transaction['balance']}",
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const GlobalBottomBar(),
      floatingActionButton: CircularFloatingButton(
        iconData: Icons.share_rounded,
        onPressed: () async {
          print("Share Transaction");

          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return GenerateXlsx(
                  transactionData: dataForXlsx,
                  transactionSum: d1TOd2Transaction,
              );
            },
          );
          // await Share.share('Hello Finance');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
    );
  }
}
