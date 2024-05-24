import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/borderDecoratedContainer.dart';

class TransactionTableRow extends StatefulWidget {
  final String? date;
  final String? debit;
  final String? credit;
  final String? total;
  final FontWeight? fontWeight;

  final double height;

  const TransactionTableRow({
    super.key,
    this.date,
    this.debit,
    this.credit,
    this.total,
    required this.height,
    this.fontWeight,
  });

  @override
  State<TransactionTableRow> createState() => _TransactionTableRowState();
}

class _TransactionTableRowState extends State<TransactionTableRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(
                child: Text('${widget.date}',
                  style: TextStyle(
                    fontWeight: widget.fontWeight?? FontWeight.normal,
                  ),
                )
            ),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(
                child: Text(
                  '${widget.debit}',
                  style: TextStyle(
                    fontWeight: widget.fontWeight?? FontWeight.normal,
                  ),
                )
            ),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(
                child: Text(
                  '${widget.credit}',
                  style: TextStyle(
                    fontWeight: widget.fontWeight?? FontWeight.normal,
                  ),
                )
            ),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            child: Center(
                child: Text(
                  '${widget.total}',
                  style: TextStyle(
                    fontWeight: widget.fontWeight?? FontWeight.normal,
                  ),
                )
            ),
          ),
        ),
      ],
    );
  }
}
