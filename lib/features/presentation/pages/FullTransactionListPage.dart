import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/containers/transactionCards.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/transactionFilter.dart';
import 'package:finance/features/presentation/widgets/popUps/fromDialog.dart';
import 'package:finance/features/presentation/widgets/froms/transactionAddForm.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';

import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/data/models/particular_transaction_model.dart';
import 'package:finance/features/data/models/date_wise_transaction_model.dart';


class FullTransactionListPage extends StatefulWidget {
  const FullTransactionListPage({super.key});

  @override
  State<FullTransactionListPage> createState() => _FullTransactionListPageState();
}

class _FullTransactionListPageState extends State<FullTransactionListPage> {
  String startDate = convertYyMmDd(getPreviousDate(31));
  String endDate = convertYyMmDd(getPreviousDate(0));
  int year = DateTime.now().year.toInt();

  //DATABASE RELATED JOB
  DbHelper? dbHelper;
  late Future<List<DateWiseTransactionModel>> dateWiseTransactionList;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadDaysTransaction(startDate, endDate);
  }

  // LOAD DATE-WISE TRANSACTION ACCORDING TO DATE
  loadDaysTransaction(String start, String end) async {
    dateWiseTransactionList = dbHelper!.queryDateWiseItemsBetweenDates(start, end);
    // List<DateWiseTransactionModel> dateWiseTransaction = await dbHelper!.queryDateWiseItemsBetweenDates(start, end);
  }

  // INSERT INDIVIDUAL TRANSACTION
  void insertTransaction(Map<String, dynamic> data) async {
    dbHelper!.insertIndividualTransaction(
      ParticularTransactionModel(
        year: DateTime.now().year.toInt(),
        date: data['date'],
        amount: data['amount'],
        payer: null,
      ),
    ).then((value){
      setState(() {
        loadDaysTransaction(startDate, endDate);
      });
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueSecondary,
      body: SafeArea(
        child: appBackgroundContainer(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ===========[ DATE FILTER CONTAINER ]=============
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TransactionFilter(
                      dropDownList: ['Range', 'Particular'],
                        filterData: (Map<String, dynamic> data){
                        print("${data['startDate']}, ${data['endDate']}");
                          setState(() {
                            loadDaysTransaction(data['startDate'], data['endDate']);
                          });
                        }
                    ),
                  ),

                  // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
                  Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: MediaQuery.of(context).size.height - 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    // child: ListView.builder(
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.vertical,
                    //     itemCount: 50,
                    //     itemBuilder: (context, index){
                    //       return Padding(
                    //         padding: EdgeInsets.only(bottom: 4.0),
                    //         child: TransactionCards(),
                    //       );
                    //     }
                    // ),
                    child: FutureBuilder(
                      future: dateWiseTransactionList,
                      builder: (context, AsyncSnapshot<List<DateWiseTransactionModel>> snapshot) {
                        if(snapshot.hasData){
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){
                                Map<String, dynamic> transaction = {
                                  'year': snapshot.data![index].year,
                                  'date': snapshot.data![index].date,
                                  'debit': snapshot.data![index].debit,
                                  'credit': snapshot.data![index].credit,
                                  'balance': snapshot.data![index].balance,
                                };
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 4.0),
                                  child: TransactionCards(
                                    cardsData: transaction,
                                  ),
                                );
                              }
                          );
                        }else{
                          return Text('no Data');
                        }
                      },
                    )
                  ),
                ],
              ),
          ),
        ),
      ),

      bottomNavigationBar: GlobalBottomBar(),
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