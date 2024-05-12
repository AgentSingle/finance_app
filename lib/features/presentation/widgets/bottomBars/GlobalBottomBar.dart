import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';
import 'package:finance/features/presentation/pages/HomePage.dart';
import 'package:finance/features/presentation/pages/FullTransactionListPage.dart';
import 'package:finance/features/presentation/pages/TransactionTablePage.dart';
import 'package:finance/features/presentation/pages/SettingsPage.dart';


class GlobalBottomBar extends StatefulWidget {
  const GlobalBottomBar({super.key});

  @override
  State<GlobalBottomBar> createState() => _GlobalBottomBarState();
}

class _GlobalBottomBarState extends State<GlobalBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: 60,
        color: blueDeep,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReUsableIconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              iconData: Icons.home,
            ),
            ReUsableIconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FullTransactionListPage()),
                );
              },
              iconData: Icons.list_alt,
            ),
            Container(
              width: 80,
            ),
            ReUsableIconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransactionTablePage()),
                );
              },
              iconData: Icons.receipt_long,
            ),
            ReUsableIconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AppSettingsPage()),
                );
              },
              iconData: Icons.settings,
            ),
          ],
        ),
      );
  }
}


class ReUsableIconButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;

  const ReUsableIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    this. color,
    this.size
  });

  @override
  State<ReUsableIconButton> createState() => _ReUsableIconButtonState();
}

class _ReUsableIconButtonState extends State<ReUsableIconButton> {


  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 8),
      icon: Icon(
        widget.iconData,
        size: widget.size ?? 30,
        color: widget.color ?? Colors.white,
      ),
      onPressed: widget.onPressed,
    );
  }
}

