import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';

class CircularFloatingButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CircularFloatingButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  State<CircularFloatingButton> createState() => _CircularFloatingButtonState();
}

class _CircularFloatingButtonState extends State<CircularFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 4,
      onPressed: widget.onPressed,
      tooltip: 'Center FAB',
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35)
      ),
      child: Icon(widget.iconData, color: blueDeep, size: 30,),
    );
  }
}
