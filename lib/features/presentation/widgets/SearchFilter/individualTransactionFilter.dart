import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';
import 'package:finance/features/presentation/widgets/dropDown/dropdownWithReturnValue.dart';
import 'package:finance/features/presentation/widgets/popUps/dateSelector.dart';
import 'package:flutter/widgets.dart';


class IndividualTransactionFilter extends StatefulWidget {
  final List<String> dropDownList;

  const IndividualTransactionFilter({
    super.key,
    required this.dropDownList,
  });

  @override
  State<IndividualTransactionFilter> createState() => _IndividualTransactionFilterState();
}

class _IndividualTransactionFilterState extends State<IndividualTransactionFilter> {


  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    /* ____________________________[ RANGE ]____________________________ */
    Row(
      children: [
        DateSelector(
          label: 'Start Date',
          dateString: getPreviousDate(31),
        ),
        DateSelector(
          label: 'End Date',
          dateString: getCurrentDate(),
        ),
      ],
    ),
    /* ____________________________[ PARTICULAR ]____________________________ */
    Row(
      children: [
        DateSelector(
          label: 'Select A Date',
          dateString: getCurrentDate(),
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
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
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
          ),
          Container(
            height: 30,
            // color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: (22/7),
                            child: const Icon(
                              Icons.arrow_outward,
                              size: 20,
                              color: Colors.green,
                            )
                          ),
                          const Icon(
                            Icons.arrow_outward,
                            size: 20,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    )
                  ),
                  const Expanded(
                    child: Text(
                      'Balance',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
