import 'package:flutter/material.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}
class _AddDetailsState extends State<AddDetails> {
  String dropdownvalue = 'Female';
  String dropdownvalue1 = 'Type1';
  var diabetisType = ['Type1', 'Type 2'];
  var gender = ['Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        myPadding('Address'),
        SizedBox(height: 20),
        myPadding('Date of Birth'),
        Row(
          children: [
            Text('Gender='),
            DropdownButton(
              value: dropdownvalue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: gender.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
        myPadding('HEight'),
        myPadding('Weight'),
        Row(
          children: [
            Text('Diabetes'),
            DropdownButton(
              value: dropdownvalue1,
              icon: Icon(Icons.keyboard_arrow_down),
              items: diabetisType.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue1 = newValue!;
                });
              },
            ),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: Text('Save')),
      ],
    ));
  }
}

Padding myPadding(String text) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: text,
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
  );
}
