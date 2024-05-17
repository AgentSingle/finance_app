import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:finance/features/presentation/widgets/popUps/warningDialog.dart';
import 'package:finance/features/presentation/widgets/popUps/fromDialog.dart';
import 'package:finance/features/presentation/widgets/froms/transactionAddForm.dart';
import 'package:finance/features/presentation/block/temporary.dart';


class IndividualTransactionCards extends StatefulWidget {
  final int index;
  final Function(Map<String, dynamic>) actionResponse;

  const IndividualTransactionCards({
    super.key,
    required this.index,
    required this.actionResponse,
  });

  @override
  State<IndividualTransactionCards> createState() => _IndividualTransactionCardsState();
}

class _IndividualTransactionCardsState extends State<IndividualTransactionCards> {

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      'action': '',
      'id': null,
    };

    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
              icon: Icons.delete,
              backgroundColor: lightRed,
              onPressed: (context) => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WarningDialog(
                      height: 150,
                    );
                  },
                )
                // setState(() {
                //   data['action'] = 'DELETE';
                //   data['id'] = widget.index;
                //   return widget.actionResponse(data);
                // })
              }
          ),
          SlidableAction(
              icon: Icons.edit,
              backgroundColor:lightGreen,
              onPressed: (context)=> {
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
                ),
                // setState(() {
                //   data['action'] = 'UPDATE';
                //   data['id'] = widget.index;
                //   return widget.actionResponse(data);
                // })
              }
          ),
        ],
      ),
      child: TransactionCardsContent()
    );
    // return TransactionCardsContent();
  }
}


class TransactionCardsContent extends StatefulWidget {
  const TransactionCardsContent({super.key});

  @override
  State<TransactionCardsContent> createState() => _TransactionCardsContentState();
}

class _TransactionCardsContentState extends State<TransactionCardsContent> {

  @override
  Widget _getIcon(double value){
    if(value<0){
      return const Icon(Icons.arrow_outward, size: 20, color: Colors.red,);
    }
    else {
      return Transform.rotate(
          angle: (22/7),
          child: const Icon(
            Icons.arrow_outward,
            size: 20,
            color: Colors.green,
          )
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double amount = genRandomNumber();

    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width - 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 4.0, right: 8.0, bottom: 4.0, left: 8.0),
        child: Row(
          children: [
            const Expanded(
                child: Text(
                  '1-Jun-24',
                  textAlign: TextAlign.left,
                )
            ),
            Expanded(
                child: Text(
                    '${amount}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: (amount<0)? Colors.red: Colors.green,
                  ),
                )
            ),
            Expanded(
                child: Center(
                  child: _getIcon(amount),
                )
            ),
            const Expanded(
                child: Text(
                    '80,000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

