import 'package:finance/config/theme/colors/color_code.dart';
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';



/* =============================[ Date Selector ]============================= */
class DateSelector extends StatefulWidget {
  final String label;
  final String dateString;
  final double? fontSize;

  const DateSelector({
    super.key,
    required this.label,
    required this.dateString,
    this.fontSize,
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
                    fontSize: widget.fontSize?? 14,
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