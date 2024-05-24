import 'package:flutter/material.dart';
import 'package:finance/features/presentation/widgets/dropDown/dropdownWithReturnValue.dart';
import 'package:finance/features/presentation/widgets/popUps/dateSelector.dart';


class TransactionFilter extends StatefulWidget {
  final List<String> dropDownList;
  final Function(Map<String, dynamic>) filterData;

  const TransactionFilter({
    super.key,
    required this.dropDownList,
    required this.filterData,
  });

  @override
  State<TransactionFilter> createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  Map<String, dynamic> data = {'startDate': '', 'endDate': ''};

  void setStartDate(String value) {
    setState(() {
      data['startDate'] = value;
      if(data['endDate']!= ''){
        return widget.filterData(data);
      }
    });
  }

  void setEndDate(String value) {
    setState(() {
      data['endDate'] = value;
      return widget.filterData(data);
    });
  }

  void setSameStartEndDate(String value) {
    setState(() {
      data['startDate'] = value;
      data['endDate'] = value;
      return widget.filterData(data);
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
      /* ____________________________[ RANGE ]____________________________ */
      Row(
        children: [
          DateSelector(
            label: 'Start Date',
            dateDifference: 31,
            responseDate: (value){
              setStartDate(value);
            },
          ),
          DateSelector(
            label: 'End Date',
            responseDate: (value){
              setEndDate(value);
            },
          ),
        ],
      ),
      /* ____________________________[ PARTICULAR ]____________________________ */
      Row(
        children: [
          DateSelector(
            label: 'Select A Date',
            responseDate: (value){
              setSameStartEndDate(value);
            },
          ),
        ],
      ),
    ];

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
