import 'package:finance/config/theme/colors/color_code.dart';
import 'package:flutter/material.dart';
import 'package:finance/features/presentation/block/DateFormatter.dart';



/* =============================[ Date Selector ]============================= */
class DateSelector extends StatefulWidget {
  final String label;
  final int? dateDifference;
  final double? fontSize;
  final Function(String)? responseDate;

  const DateSelector({
    super.key,
    required this.label,
    this.dateDifference,
    this.fontSize,
    this.responseDate,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String givenDate = "";

  @override
  void initState(){
    super.initState();
    String getDate = getPreviousDate(widget.dateDifference??0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setNewDate(getDate);
    });
  }

  void setNewDate(String getDate){
    setState(() {
      givenDate = formatDate(getDate);
    });
    if(widget.responseDate!=null){
      return widget.responseDate!(convertYyMmDd(getDate));
    }
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
          setNewDate(getDate);
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