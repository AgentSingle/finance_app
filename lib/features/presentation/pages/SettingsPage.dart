
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/IconWithTextButton.dart';
import 'package:finance/features/presentation/widgets/containers/appBackgroundContainer.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/data/data_sources/dbHelper.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/circularFloatingButton.dart';
import 'package:finance/features/presentation/widgets/bottomBars/GlobalBottomBar.dart';
import 'package:finance/features/presentation/widgets/popUps/warningDialog.dart';
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
                      // ================ BACKUP DATABASE ACTION =====================
                      IconsWithTextButton(
                        onTap: () async{
                          await DbHelper().backupDB();
                          _displayBottomSheet(context, 'DataBase Successfully Backup.');
                        },
                        text: 'Backup Database',
                        textColor: blueDeep,
                        icon: const Icon(
                          Icons.save_alt,
                          color: blueDeep,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),

                      // ================ RESTORE DATABASE ACTION =====================
                      IconsWithTextButton(
                        onTap: () async{
                          await DbHelper().restoreDB();
                          _displayBottomSheet(context, 'Successfully Restore DataBase.');
                        },
                        text: 'Restore Database',
                        textColor: lightGreen,
                        icon: const Icon(
                          Icons.restart_alt,
                          color: lightGreen,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),

                      // ================ DELETE DATABASE ACTION =====================
                      IconsWithTextButton(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WarningDialog(
                                height: 150,
                                onDelete: () async{
                                  await DbHelper().deleteDB();
                                  Navigator.pop(context);
                                  _displayBottomSheet(context, 'Database Deleted.');
                                },
                              );
                            },
                          );
                        },
                        text: 'Delete Database',
                        textColor: lightRed,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: lightRed,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context, String textData){
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(10)
            )
        ),
        builder: (context) => SizedBox(
          height: 80,
          child: Center(
              child: Text(
                  textData,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)
              )
          ),
        )
    );
  }
}


