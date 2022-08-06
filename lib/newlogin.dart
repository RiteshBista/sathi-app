import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sathi_app/main.dart';
import 'package:sathi_app/screen/forgot_password_page.dart';
import 'Utils.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
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
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  // SizedBox(height: 70),
                  Image(
                    alignment: Alignment.center,
                    height: 300.0,
                    width: 300.0,
                    image: AssetImage('assets/images/1.png'),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                  ),

                  Column(
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
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? "Enter at least 6 characters"
                            : null,
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

                      ElevatedButton(
                        onPressed: signIn,
                        child: Text('Login'),
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

                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          text: 'Don\'t have an account?',
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignUp,
                            text: 'Sign up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ))
                      ])),
                  ElevatedButton(
                    child: Text('Forgot Password'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage())),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
    } on FirebaseException catch (error) {
      Utils.showSnackBar(error.message);
    }
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}
