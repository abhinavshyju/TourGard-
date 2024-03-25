import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelectionChanged;

  const DropdownMenuExample({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            widget.onSelectionChanged(
                value); // Call the callback function with the selected value.
          });
        },
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        underline: Container(
            // height: 2,
            // color: Color.fromARGB(108, 110, 110, 110),
            ),
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
