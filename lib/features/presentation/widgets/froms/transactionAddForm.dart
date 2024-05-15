import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/ReUsableSquareButton.dart';
import 'package:finance/features/presentation/widgets/popUps/dateSelector.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';


class TransactionAddingForm extends StatefulWidget {
  final double? height;

  const TransactionAddingForm({
    super.key,
    this.height,
  });

  @override
  State<TransactionAddingForm> createState() => _TransactionAddingFormState();
}

class _TransactionAddingFormState extends State<TransactionAddingForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                    flex: ((widget.height??250)/10).round() - 5,
                    child: Container(
                      // color: Colors.yellow,
                      child: Column(
                        children: [
                          DateSelector(
                            label: 'Entry Date',
                            fontSize: 20,
                            dateString: getCurrentDate(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(
                                //   width: 2,
                                //   color: Colors.red
                                // ),
                              ),
                              labelText: 'Debit Amount',
                              labelStyle: TextStyle(
                                  color: lightGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(
                                //   width: 2,
                                //   color: Colors.red
                                // ),
                              ),
                              labelText: 'Credit Amount',
                              labelStyle: TextStyle(
                                  color: lightRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),

                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ReUsableSquareButton(
                          pR: 4,
                          color: lightRed,
                          textColor: Colors.white,
                          text: "Close",
                          onTap: (){
                            Navigator.pop(context);
                            print("Cancel Button Clicked");
                          },
                        ),
                      ),

                      Expanded(
                        child: ReUsableSquareButton(
                          pL: 4,
                          color: lightGreen,
                          textColor: Colors.white,
                          text: "Save",
                          onTap: (){
                            print("Cancel Button Clicked");
                          },
                        ),
                      )

                    ],
                  )
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
