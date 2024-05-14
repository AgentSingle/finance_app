import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';


class FromDialog extends StatefulWidget {
  final Widget? child;
  final double? height;

  const FromDialog({
    super.key,
    this.child,
    this.height,
  });

  @override
  State<FromDialog> createState() => _FromDialogState();
}

class _FromDialogState extends State<FromDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: backDrop,
      child: Container(
        height: widget.height?? 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          // gradient: LinearGradient(
          //   colors: [Color(0xffebf1ff), Color(0xffd6e0ff)],
          //   stops: [0, 1],
          //   begin: Alignment.bottomCenter,
          //   end: Alignment.topCenter,
          // )

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.child?? Text("No content"),
        ),
      ),
    );
  }
}
