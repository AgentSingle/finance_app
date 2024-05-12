import 'package:flutter/material.dart';

class dropdownWithReturnValue extends StatefulWidget {
  final List<String> dropDownList;
  final Function(String) dropDownCallback;

  const dropdownWithReturnValue({
    super.key,
    required this.dropDownList,
    required this.dropDownCallback
  });

  @override
  State<dropdownWithReturnValue> createState() => _dropdownWithReturnValueState();
}

class _dropdownWithReturnValueState extends State<dropdownWithReturnValue> {
  String dropdownValue = "";

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    dropdownValue = (widget.dropDownList != []) ? widget.dropDownList.first: "";
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, size: 30,),
      underline: Container(height: 0),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.dropDownCallback(dropdownValue);
        });
      },
      items: widget.dropDownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}