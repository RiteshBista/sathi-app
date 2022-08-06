import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:sathi_app/main.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  String name = "Suban";
  String dropdownvalue = 'Female';
  String dropdownvalue1 = 'Type1';
  String trustedPerson = "";
  String doctorName = "";
  int trusedNumber = 0;
  int doctorNumber = 0;
  int age = 0;
  var diabetisType = ['Type1', 'Type 2'];
  var gender = ['Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Name"),
          onChanged: (value) => setState(() {
            name = value;
          }),
        ),
        myPadding("Trusted Person's Name"),
        TextField(
          decoration: const InputDecoration(labelText: "Trusted Person's Number"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => setState(() {
            trusedNumber = int.parse(value);
          }),
        ),
        myPadding("Doctor's Name"),
        TextField(
          decoration: const InputDecoration(labelText: "Doctor's Number"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {setState(() {
            doctorNumber = int.parse(value);
          });},
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Age"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {setState(() {
            age = int.parse(value);
          });},
        ),
        Row(
          children: [
            const Text('Gender='),
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
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
        Row(
          children: [
            const Text('Diabetes'),
            DropdownButton(
              value: dropdownvalue1,
              icon: const Icon(Icons.keyboard_arrow_down),
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
        ElevatedButton(
            onPressed: () {
              createUserDocument();
            },
            child: const Text('Save')),
      ],
    ));
  }

  Future createUserDocument() async {
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(user?.uid).set({
      'name': name,
      'gender': dropdownvalue,
      'trustedNumber': trusedNumber,
      'trustedPerson': trustedPerson,
      'doctorName': doctorName,
      'doctorNumber': doctorNumber,
      'age': age,
      'type': dropdownvalue1 == "Type1" ? true : false,
      'email': user?.email,
    }).then((value) {
      print("user added");
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
    }).catchError((error) => print(error));
  }
}

Padding myPadding(String text) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      decoration: InputDecoration(
        labelText: text,
      ),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
  );
}
