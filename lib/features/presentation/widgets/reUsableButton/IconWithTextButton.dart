import 'package:flutter/material.dart';


class IconsWithTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String text;
  final Color? textColor;

  const IconsWithTextButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    this.textColor,
  });

  @override
  State<IconsWithTextButton> createState() => _IconsWithTextButtonState();
}

class _IconsWithTextButtonState extends State<IconsWithTextButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    '${widget.text}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor?? Colors.black,
                    ),
                  )
              ),
              Expanded(
                flex: 1,
                child: widget.icon,
              ),
            ],
          ),
        ),
        // Styling container
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
