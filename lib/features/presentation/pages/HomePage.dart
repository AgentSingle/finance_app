import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/containers/Home/revenueContainer.dart';
import 'package:finance/features/presentation/widgets/containers/transactionCards.dart';
import 'package:finance/features/presentation/widgets/SearchFilter/transactionFilter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluePrimary,
      body: SafeArea(
        child: appBackgroundContainer(
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
                child: TransactionFilter(
                  dropDownList: ['Range', 'Particular'],
                ),
              ),
        
              // ===========[ LAST IMPORTANT TRANSACTION LIST ]=============
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.height - 420,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 31,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: TransactionCards(
                        index: index,
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const GlobalBottomBar(),
      floatingActionButton: CircularFloatingButton(
        iconData: Icons.add,
        onPressed: (){
          print("Home Page Add Item");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


