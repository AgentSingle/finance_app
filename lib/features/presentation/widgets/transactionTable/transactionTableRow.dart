import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/borderDecoratedContainer.dart';

class TransactionTableRow extends StatefulWidget {
  final String? date;
  final String? debit;
  final String? credit;
  final String? total;

  final double height;

  const TransactionTableRow({
    super.key,
    this.date,
    this.debit,
    this.credit,
    this.total,
    required this.height,
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
                child: Text('${widget.date}')
            ),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(
                child: Text('${widget.debit}')
            ),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(
                child: Text('${widget.credit}')
            ),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            child: Center(
                child: Text('${widget.total}')
            ),
          ),
        ),
      ],
    );
  }
}
