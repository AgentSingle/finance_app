
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';


class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: appBackgroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: blueSecondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: blueDeep,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () async {
                    await DbHelper().deleteDB();
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.pinkAccent),
                    foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                    side: MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.green)),
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(12.0)),
                  ),
                  child: const Text('Delete Database', style: TextStyle(fontSize: 20),),
                ),
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: GlobalBottomBar(),
      // floatingActionButton: CircularFloatingButton(
      //   iconData: Icons.add,
      //   onPressed: (){
      //     print("Full List Page Action");
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


