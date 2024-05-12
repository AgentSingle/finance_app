import 'package:finance/config/theme/colors/color_code.dart';
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';
import 'package:finance/features/presentation/widgets/dropDown/dropdownWithReturnValue.dart';


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
    /* _____________________________[ ALL ]_____________________________ */
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


/* =============================[ Date Selector ]============================= */
class DateSelector extends StatefulWidget {
  final String label;
  final String dateString;

  const DateSelector({
    super.key,
    required this.label,
    required this.dateString,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String givenDate = "";

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    givenDate = formatDate(widget.dateString);
  }

  @override
  Widget build(BuildContext context) {
    Map mapDate = mapAsDate(getCurrentDate());

    return GestureDetector(
      /* ____________________________[ Date Picker ]_________________________ */
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(mapDate['year'], mapDate['month'], mapDate['day']),
          firstDate: DateTime(2010),
          lastDate: DateTime(2101),
        );
        if (selectedDate != null) {
          var getDate = '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
          setState(() {
            givenDate = formatDate(getDate);
          });
        }
      },

      /* _________________________[ Date Picker Item ]_______________________ */
      child: Row(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.label}",
                  style: TextStyle(
                    color: blueDeep,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("$givenDate")
              ],
            ),
          ),
          Container(
            width: 30,
            child: Icon(Icons.calendar_month, size: 25, color: Colors.grey,),
          )
        ],
      ),
    );
  }
}