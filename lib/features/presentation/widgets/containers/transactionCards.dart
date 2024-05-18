import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:finance/features/presentation/widgets/popUps/warningDialog.dart';
import 'package:finance/features/presentation/widgets/popUps/fromDialog.dart';
import 'package:finance/features/presentation/widgets/froms/transactionAddForm.dart';


class TransactionCards extends StatefulWidget {
  final Function(Map<String, dynamic>) actionResponse;

  const TransactionCards({
    super.key,
    required this.actionResponse,
  });

  @override
  State<TransactionCards> createState() => _TransactionCardsState();
}

class _TransactionCardsState extends State<TransactionCards> {

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      'action': '',
      'id': null,
    };

    return Slidable(
      // startActionPane: ActionPane(
      //   motion: const BehindMotion(),
      //   children: [
      //     SlidableAction(
      //         icon: Icons.delete,
      //         backgroundColor: Colors.red,
      //         onPressed: (context)=> {
      //           print(widget.index)
      //         }
      //     ),
      //   ],
      // ),
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
                        onSave: (Map<String, dynamic> data){
                          print(data);
                        },
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
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 4.0, right: 8.0, bottom: 4.0, left: 8.0),
        child: Row(
          children: [
            CardsRow(
              headerText: 'Date',
              contentText: '1-july-24',
              alignment: CrossAxisAlignment.start,
            ),
            CardsRow(
                headerText: 'Debit',
                contentText: '50,000',
                color: lightGreen,
            ),
            CardsRow(
                headerText: 'Credit',
                contentText: '5,000',
                color: lightRed,
            ),
            CardsRow(
              headerText: 'Balance',
              contentText: '45,000',
              alignment: CrossAxisAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}


/* EACH CARDS CONTENT STYLE HERE */
class CardsRow extends StatelessWidget {
  final CrossAxisAlignment? alignment;
  final String headerText;
  final String? contentText;
  final Color? color;

  const CardsRow({
    super.key,
    required this.headerText,
    this.alignment,
    this.contentText,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: alignment?? CrossAxisAlignment.center,
          children: [
            Text(
              "${headerText}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "${contentText?? ''}",
              style: TextStyle(
                color: color?? Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
