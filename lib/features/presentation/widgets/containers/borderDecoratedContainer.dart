import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';

class BorderDecoratedContainer extends StatefulWidget {
  final double height;
  final Widget child;
  final double ? tB;
  final double ? rB;
  final double ? bB;
  final double ? lB;

  const BorderDecoratedContainer({
    super.key,
    required this.height,
    required this.child,
    this.tB,
    this.rB,
    this.bB,
    this.lB,
  });

  @override
  State<BorderDecoratedContainer> createState() => _BorderDecoratedContainerState();
}

class _BorderDecoratedContainerState extends State<BorderDecoratedContainer> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: blueDeep,
            width: widget.tB?? 0,
          ),
          right: BorderSide(
            color: blueDeep,
            width: widget.rB?? 0,
          ),
          bottom: BorderSide(
            color: blueDeep,
            width: widget.bB?? 0,
          ),
          left: BorderSide(
            color: blueDeep,
            width: widget.lB?? 0,
          )
        )
      ),
      child: widget.child,
    );
  }
}
