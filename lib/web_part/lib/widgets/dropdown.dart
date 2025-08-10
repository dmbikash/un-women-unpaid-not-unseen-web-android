import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedGender,
      hint: Text('Select Sex'),
      items: genderOptions.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(
            gender,
            style: TextStyle(color: Colors.black), // Text color inside dropdown
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedGender = newValue;
        });
      },
      dropdownColor: Colors.white, // Dropdown background color
      style: TextStyle(color: Colors.blue), // Selected item text color
      iconEnabledColor: Colors.blue, // Dropdown arrow color
    );
  }
}
