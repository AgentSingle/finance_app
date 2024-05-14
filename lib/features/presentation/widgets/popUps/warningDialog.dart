import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/ReUsableSquareButton.dart';


class WarningDialog extends StatefulWidget {
  const WarningDialog({super.key});

  @override
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: backDrop,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [


              Expanded(
                flex: 10,
                child: Container(
                  // color: Colors.purple,
                  child: Column(
                    children: [

                      Expanded(
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.error_outline_outlined,
                            size: 35,
                            color: Colors.white,
                          ),
                        )
                      ),

                      const Expanded(
                        child: Center(
                            child: Text(
                              "Are You Sure To Delete!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Expanded(
                flex: 5,
                child: Row(
                  children: [

                    Expanded(
                      child: ReUsableSquareButton(
                        pR: 4,
                        color: Colors.red,
                        textColor: Colors.white,
                        text: "Delete",
                        onTap: (){
                          print("Cancel Button Clicked");
                        },
                      ),
                    ),

                    Expanded(
                      child: ReUsableSquareButton(
                        pL: 4,
                        color: Colors.greenAccent,
                        textColor: Colors.white,
                        text: "Cancel",
                        onTap: (){
                          print("Cancel Button Clicked");
                          Navigator.pop(context);
                        },
                      ),
                    )

                  ],
                )
              ),


            ],
          ),
        ),
      ),
    );
  }
}
