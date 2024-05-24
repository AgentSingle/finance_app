import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';
import 'package:flutter/widgets.dart';


class TransactionCards extends StatefulWidget {

  final Map<String, dynamic>? cardsData;

  const TransactionCards({
    super.key,
    this.cardsData,
  });

  @override
  State<TransactionCards> createState() => _TransactionCardsState();
}

class _TransactionCardsState extends State<TransactionCards> {

  @override
  Widget build(BuildContext context) {
    if(widget.cardsData!.containsKey('date1') && widget.cardsData!.containsKey('date2')){
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 8.0, bottom: 4.0, left: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${(widget.cardsData!=null)? formatDate(convertDdMmYy(widget.cardsData!['date1'])):''}',
                      style: const TextStyle(
                        fontSize: 12
                      ),
                    ),
                    Text(
                      '${(widget.cardsData!=null)? formatDate(convertDdMmYy(widget.cardsData!['date2'])):''}',
                      style: const TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
              CardsRow(
                headerText: 'Debit',
                contentText: '${(widget.cardsData!=null)? widget.cardsData!['debit']:''}',
                color: lightGreen,
              ),
              CardsRow(
                headerText: 'Credit',
                contentText: '${(widget.cardsData!=null)? widget.cardsData!['credit'].abs():''}',
                color: lightRed,
              ),
              CardsRow(
                headerText: 'Balance',
                contentText: '${(widget.cardsData!=null)? widget.cardsData!['balance']:''}',
                alignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ),
      );
    }
    else {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 4.0, right: 8.0, bottom: 4.0, left: 8.0),
          child: Row(
            children: [
              CardsRow(
                headerText: 'Date',
                contentText: '${(widget.cardsData!=null)? formatDate(convertDdMmYy(widget.cardsData!['date'])):''}',
                alignment: CrossAxisAlignment.start,
              ),
              CardsRow(
                headerText: 'Debit',
                contentText: '${(widget.cardsData!=null)? widget.cardsData!['debit']:''}',
                color: lightGreen,
              ),
              CardsRow(
                headerText: 'Credit',
                contentText: '${(widget.cardsData!=null)? widget.cardsData!['credit'].abs():''}',
                color: lightRed,
              ),
              CardsRow(
                headerText: 'Balance',
                contentText: '${(widget.cardsData!=null)? widget.cardsData!['balance']:''}',
                alignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ),
      );
    }
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${contentText?? ''}",
                    style: TextStyle(
                      color: color?? Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
