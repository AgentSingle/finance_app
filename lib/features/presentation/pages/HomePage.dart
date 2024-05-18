import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/containers/Home/revenueContainer.dart';
import 'package:finance/features/presentation/widgets/containers/transactionCards.dart';
import 'package:finance/features/presentation/widgets/containers/individualTransactionCard.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/individualTransactionFilter.dart';
import 'package:finance/features/presentation/widgets/popUps/fromDialog.dart';
import 'package:finance/features/presentation/widgets/froms/transactionAddForm.dart';

import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/data/models/particular_transaction_model.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //DATABASE RELATED JOB
  DbHelper? dbHelper;
  late Future<List<ParticularTransactionModel>> particularTransactionList;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadData();
  }
  loadData() async {
    particularTransactionList = dbHelper!.getParticularTransactionList();
    print(particularTransactionList);
  }

  // List<dynamic> newParticularTransaction = [{
  //   'id': null,
  //   'year': DateTime.now().year,
  //   'date': '${DateTime.now().year}-${6}-${01}',
  //   'amount': 5000,
  //   'balance': 5000,
  //   'payer': '',
  // }];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluePrimary,
      body: SafeArea(
        child: appBackgroundContainer(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ===========[ ANNUAL-REVENUE CONTAINER ]=============
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: revenueContainer(),
                ),

                // ===========[ DATE FILTER CONTAINER ]=============
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: IndividualTransactionFilter(
                    dropDownList: ['Range', 'Particular'],
                  ),
                ),

                // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
                Container(
                  width: MediaQuery.of(context).size.width - 16,
                  height: MediaQuery.of(context).size.height - 500,

                  child: FutureBuilder(
                    future: particularTransactionList,
                    builder: (context, AsyncSnapshot<List<ParticularTransactionModel>> snapshot) {
                      if(snapshot.hasData){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  // child: Text('${snapshot.data![index].date}'),
                                  child: IndividualTransactionCards(
                                    index: snapshot.data![index].id?? index,
                                    date: snapshot.data![index].date,
                                    amount: snapshot.data![index].amount,
                                    balance: snapshot.data![index].balance,
                                    actionResponse: (data){
                                      print(snapshot.data![index]);
                                    },
                                  ),
                                );
                              }
                          ),
                          // ),
                        );
                      }
                      else{
                        return Text("No Data Found");
                      }
                    }
                  ),

                ),
                Container(
                  width: MediaQuery.of(context).size.width - 16,
                  height: 70,
                  child: TransactionCards(
                    actionResponse: (Map<String, dynamic> data){
                      print(data['action']);
                    }
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
                    print(data);
                    dbHelper!.insert(
                      ParticularTransactionModel(
                        year: DateTime.now().year.toInt(),
                        date: '${DateTime.now().year}-${6}-${01}',
                        amount: 5000,
                        balance: 5000,
                        payer: null,
                      ),
                    )
                    .then((value){
                      print("Success");
                      setState(() {
                        particularTransactionList = dbHelper!.getParticularTransactionList();
                      });
                    })
                    .onError((error, stackTrace){
                      print(error.toString());
                    });
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



