import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/transactionTable/transactionTableRow.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/transactionFilter.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';

class TransactionTablePage extends StatefulWidget {
  const TransactionTablePage({super.key});

  @override
  State<TransactionTablePage> createState() => _TransactionTablePageState();
}

class _TransactionTablePageState extends State<TransactionTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluePrimary,
      body: SafeArea(
        child: appBackgroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ===========[ DATE FILTER CONTAINER ]=============
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TransactionFilter(
                  dropDownList: ['Range', 'Particular', 'All'],
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
                    color: blueDeep,
                  ),
                ),
                child: const TransactionTableRow(
                  height: 45,
                  date: "Date",
                  debit: "Debit",
                  credit: "Credit",
                  total: "Balance",
                ),
              ),

              // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.height - 290,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 50,
                  itemBuilder: (context, index){
                    return Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width - 16,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: TransactionTableRow(
                        height: 35,
                        date: formatDate(getCurrentDate()),
                        debit: 1000.toString(),
                        credit: 450.toString(),
                        total: 550.toString(),
                      ),
                    );
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
                    color: blueDeep,
                  ),
                ),
                child: const TransactionTableRow(
                  height: 45,
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const GlobalBottomBar(),
      floatingActionButton: CircularFloatingButton(
        iconData: Icons.save_alt,
        onPressed: (){
          print("Full List Page Action");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
    );
  }
}
