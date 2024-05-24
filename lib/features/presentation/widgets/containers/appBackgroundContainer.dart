import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';

class appBackgroundContainer extends StatefulWidget {
  final Widget child;

  const appBackgroundContainer({
    super.key,
    required this.child,
  });

  @override
  State<appBackgroundContainer> createState() => _appBackgroundContainerState();
}

class _appBackgroundContainerState extends State<appBackgroundContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [blueDeep, blueSecondary],
          stops: [0.20, 0.90],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: widget.child,
    );
  }
}

