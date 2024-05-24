
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


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
              // CUSTOM TOP BAR
              Container(
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: blueDeep,
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
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),

              // BODY SECTION
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text('Backup Database', style: TextStyle(fontSize: 18),)
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Icon(Icons.save_alt, size: 30, color: blueDeep,)
                              ),
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: 8),
                      Container(
                          height: 60,
                          color: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text('Restore Database', style: TextStyle(fontSize: 18),)
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.restart_alt, size: 30, color: lightGreen,)
                                ),
                              ],
                            ),
                          )
                      ),
                      SizedBox(height: 8),
                      Container(
                          height: 60,
                          color: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text('Delete Database', style: TextStyle(fontSize: 18),)
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Icon(Icons.delete_outline, size: 30, color: lightRed,)
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: OutlinedButton(
              //     onPressed: () async {
              //       await DbHelper().deleteDB();
              //     },
              //     style: const ButtonStyle(
              //       backgroundColor: MaterialStatePropertyAll<Color>(Colors.pinkAccent),
              //       foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              //       side: MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.green)),
              //       padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(12.0)),
              //     ),
              //     child: const Text('Delete Database', style: TextStyle(fontSize: 20),),
              //   ),
              // ),
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


