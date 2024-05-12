import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionCards extends StatefulWidget {
  final int index;
  const TransactionCards({
    super.key,
    required this.index,
  });

  @override
  State<TransactionCards> createState() => _TransactionCardsState();
}

class _TransactionCardsState extends State<TransactionCards> {
  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Colors.red,
              onPressed: (context)=> {
                print(widget.index)
              }
          ),
          SlidableAction(
              icon: Icons.edit,
              backgroundColor: Colors.green,
              onPressed: (context)=> {
                print(widget.index)
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
                color: Colors.green
            ),
            CardsRow(
                headerText: 'Credit',
                contentText: '5,000',
                color: Colors.red
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
