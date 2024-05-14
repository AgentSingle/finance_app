import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/reUsableButton/ReUsableSquareButton.dart';


class TransactionAddingForm extends StatefulWidget {
  const TransactionAddingForm({super.key});

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
                    flex: 20,
                    child: Container(
                      // color: Colors.yellow,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(
                                //   width: 2,
                                //   color: Colors.red
                                // ),
                              ),
                              labelText: 'Enter Debit Amount',
                              labelStyle: TextStyle(
                                color: Colors.green,
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
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(
                                //   width: 2,
                                //   color: Colors.red
                                // ),
                              ),
                              labelText: 'Enter Credit Amount',
                              labelStyle: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
                          color: Colors.greenAccent,
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
