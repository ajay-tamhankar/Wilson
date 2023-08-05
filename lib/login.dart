import 'package:flutter/material.dart';
import 'package:winson_wings/Common%20Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:winson_wings/Dashboard.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await widget._auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Login Success");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Dash()));
      // Handle successful sign-in, e.g., navigate to the next screen.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        FlutterError("Invalid Credentials");
      }
      print("Login other exceptions.");
      // Handle other exceptions.
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 700,
            height: 400,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 70,child: Text("Email")),
                    Common.CmnTxtFld(email, "Enter Email", true,50,300),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width:70,child: Text("Password")),
                    Common.CmnTxtFld(pass, 'Enter Password', true,50,180)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){
                  _signInWithEmailAndPassword(email.text, pass.text);
                }, child: const Text("Log in"))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
