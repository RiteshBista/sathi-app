import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sathi_app/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sathi_app/screen/adddetails.dart';
import 'Utils.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignupPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image(
                  alignment: Alignment.center,
                  height: 300.0,
                  width: 300.0,
                  image: AssetImage('assets/images/1.png'),
                ),
                Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
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
                      SizedBox(height: 10),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: signUp,
                        child: Text('Signup'),
                      )
                      // FillButton(
                      //   title: 'Login',
                      //   color: BrandColors.colorGreen,
                      //   onPressed: () async {
                      //     // Check Network Availability
                      //     var connectivityResult =
                      //         await Connectivity().checkConnectivity();

                      //     if (connectivityResult != ConnectivityResult.mobile &&
                      //         connectivityResult != ConnectivityResult.wifi) {
                      //       showSnackBar("No Internet Connectivity.");
                      //       return;
                      //     }

                      //     if (passwordController.text.length < 8) {
                      //       showSnackBar("Please enter a valid password");
                      //       return;
                      //     }

                      //     login();
                      //   },
                      // ),
                    ],
                  ),
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        text: 'Already have an account?',
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: 'Log In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ))
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      // createUserDocument(user);
    } on FirebaseException catch (error) {
      Utils.showSnackBar(error.message);
    }
    Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddDetails()));
    // navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }

  
}
