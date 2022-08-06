import 'package:flutter/material.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({Key? key}) : super(key: key);

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  DateTime date = DateTime(2022, 08, 05);
  int pillcount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text('${date.year}/${date.month}/${date.day}'),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));
              if (newDate == null) return;
              setState(() => date = newDate);
            },
            child: Text('Select Date')),
        Container(
          child: Column(children: [
            Text('Pill Name'),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Medicine',
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                  )),
            ),
            Container(
              child: Row(children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        pillcount++;
                      });
                    },
                    icon: Icon(Icons.add)),
                Text(pillcount.toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        pillcount--;
                      });
                    },
                    icon: Icon(Icons.minimize)),
              ]),
            )
          ]),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Save'))
      ]),
    );
  }
}
