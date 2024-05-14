import 'package:flutter/material.dart';

class ReUsableSquareButton extends StatefulWidget {
  final double? pT;
  final double? pR;
  final double? pB;
  final double? pL;
  final Color? color;
  final Color? textColor;
  final String? text;
  final VoidCallback onTap;

  const ReUsableSquareButton({
    super.key,
    this.pT,
    this.pR,
    this.pB,
    this.pL,
    this.color,
    this.textColor,
    this.text,
    required this.onTap,
  });

  @override
  State<ReUsableSquareButton> createState() => _ReUsableSquareButtonState();
}

class _ReUsableSquareButtonState extends State<ReUsableSquareButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.pT?? 0,
        right: widget.pR?? 0,
        bottom: widget.pB?? 0,
        left: widget.pL?? 0,
      ),

      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color?? Colors.blueAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Text(
                "${widget.text?? 'Text!'}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: widget.textColor?? Colors.black,
                ),
              )
          ),
        ),
      ),
    );
  }
}
