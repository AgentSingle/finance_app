import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/containers/borderDecoratedContainer.dart';

class TransactionTableRow extends StatefulWidget {
  final double height;

  const TransactionTableRow({
    super.key,
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
            child: Center(child: Text('Date')),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(child: Text('Debit')),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            rB: 1,
            child: Center(child: Text('Credit')),
          ),
        ),
        Expanded(
          child: BorderDecoratedContainer(
            height: widget.height,
            child: Center(child: Text('Balance')),
          ),
        ),
      ],
    );
  }
}
