import 'package:flutter/material.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';
import 'package:finance/features/presentation/widgets/dropDown/dropdownWithReturnValue.dart';
import 'package:finance/features/presentation/widgets/popUps/dateSelector.dart';


class TransactionFilter extends StatefulWidget {
  final List<String> dropDownList;

  const TransactionFilter({
    super.key,
    required this.dropDownList,
  });

  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {


  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    /* ____________________________[ RANGE ]____________________________ */
    Row(
      children: [
        DateSelector(
          label: 'Start Date',
          dateDifference: 31,
        ),
        DateSelector(
          label: 'End Date',
        ),
      ],
    ),
    /* ____________________________[ PARTICULAR ]____________________________ */
    Row(
      children: [
        DateSelector(
          label: 'Select A Date',
        ),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [

          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _widgetOptions.elementAt(_selectedIndex),
            )
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: dropdownWithReturnValue(
                  dropDownList: widget.dropDownList,
                  dropDownCallback: (value){
                    _onItemTapped(widget.dropDownList.indexOf(value));
                  }
                ),
              ),
            )
          )

        ],
      ),
    );
  }
}
