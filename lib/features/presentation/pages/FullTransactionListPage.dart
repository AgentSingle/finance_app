import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/containers/transactionCards.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/transactionFilter.dart';
import 'package:finance/features/presentation/widgets/popUps/fromDialog.dart';
import 'package:finance/features/presentation/widgets/froms/transactionAddForm.dart';


class FullTransactionListPage extends StatefulWidget {
  const FullTransactionListPage({super.key});

  @override
  State<FullTransactionListPage> createState() => _FullTransactionListPageState();
}

class _FullTransactionListPageState extends State<FullTransactionListPage> {
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
                  // ===========[ DATE FILTER CONTAINER ]=============
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TransactionFilter(
                      dropDownList: ['Range', 'Particular', 'All'],
                    ),
                  ),

                  // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
                  Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 50,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: TransactionCards(
                              actionResponse: (Map<String, dynamic> data){
                                print(data);
                              },
                            ),
                          );
                        }
                    ),
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