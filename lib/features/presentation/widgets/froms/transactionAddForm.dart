import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/ReUsableSquareButton.dart';
import 'package:finance/features/presentation/widgets/popUps/dateSelector.dart';


class TransactionAddingForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final double? height;

  const TransactionAddingForm({
    super.key,
    required this.onSave,
    this.height,
  });

  @override
  State<TransactionAddingForm> createState() => _TransactionAddingFormState();
}

class _TransactionAddingFormState extends State<TransactionAddingForm> {
  double amount = 0.0;
  Map<String, dynamic> data = {'amount': 0.0, 'date': 'null'};

  void _onDebitChanged(String text) {
    setState(() {
      amount = (text!="" && text!="0")? double.parse(text): 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
                          responseDate: (value) {
                            setState(() {
                              data['date'] = value.toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: _onDebitChanged,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            labelText: 'Enter Amount',
                            labelStyle: TextStyle(
                                color: blueDeep,
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
                          text: "Credit",
                          onTap: (){
                            // print(amount);
                            if(amount!=0.0){
                              setState(() {
                                data['amount'] = -amount;
                              });
                              widget.onSave(data);
                              Navigator.pop(context);
                            }
                            // print("Cancel Button Clicked");
                          },
                        ),
                      ),

                      Expanded(
                        child: ReUsableSquareButton(
                          pL: 4,
                          color: lightGreen,
                          textColor: Colors.white,
                          text: "Debit",
                          onTap: (){
                            // print(amount);
                            if(amount!=0.0){
                              setState(() {
                                data['amount'] = amount;
                              });
                              widget.onSave(data);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )

                    ],
                  )
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ReUsableSquareButton(
                          color: blueDeep,
                          textColor: Colors.white,
                          text: "Close",
                          onTap: (){
                            Navigator.pop(context);
                            print("Cancel Button Clicked");
                          },
                        ),
                      ),
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
