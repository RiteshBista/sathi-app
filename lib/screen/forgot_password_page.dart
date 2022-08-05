import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sathi_app/Utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 50,
          ),
          SizedBox(width: 20),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('Enter your email'),
          ),
          TextFormField(
            controller: emailcontroller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0,
                )),
            style: TextStyle(fontSize: 14),
          ),
          ElevatedButton(onPressed: verifyemail, child: Text('Reset Password'))
        ],
      ),
    );
  }

  Future verifyemail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      Utils.showSnackBar('Reset password sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
