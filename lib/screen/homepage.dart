import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('this is me'),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('Signout')),
        ],
      ),
    );
  }
}
