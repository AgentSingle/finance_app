import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';


class TransactionCards extends StatefulWidget {

  const TransactionCards({
    super.key,
  });

  @override
  State<TransactionCards> createState() => _TransactionCardsState();
}

class _TransactionCardsState extends State<TransactionCards> {

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
    // return TransactionCardsContent();
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
