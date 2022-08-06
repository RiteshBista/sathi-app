import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var name = "Suban";
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void onClickNotification(String? payload) {
    // Navigator.of(context).push(route)
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
    }

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: users.doc(user!.uid).get(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text("has error");
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Text("Full Name: ${data['name']} type: ${data['type'] == 'true'? "1": "2"}");
              }
              return Text('loading');
            }),
          ),
          	
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
