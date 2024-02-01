// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Screens/HomePage.dart';
import 'package:note_app/Screens/register.dart';

class LoginUsers extends StatefulWidget {
  const LoginUsers({super.key});

  @override
  State<LoginUsers> createState() => _LoginUsersState();
}

class _LoginUsersState extends State<LoginUsers> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // FirestoreService fbService = FirestoreService();

  final fireauth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void loginFn() async {
    try {
      fireauth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 233, 210, 166),
        Color.fromARGB(255, 198, 191, 156),
        Color.fromARGB(255, 175, 160, 82),
        Color.fromARGB(255, 159, 159, 113)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0x00000000),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Email"),
                      controller: emailController,
                      // validator: (value) {
                      //   final bool isValid =
                      //       EmailValidator.validate(value.toString());
                      //   return isValid ? null : "Enter a valid Email";
                      // },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Password"),
                    controller: passController,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(
                      //   builder: (context) => NewPassword(),
                      // ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 17),
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Colors.black87)),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: const ButtonStyle(),
                onPressed: () {
                  loginFn();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ));
                },
                child: const Text("LOGIN"),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                  "------------------------------------------OR----------------------------------------"),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Need an Account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    InkWell(
                        onTap: () {
                          _formKey.currentState!.validate();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegUsers(),
                          ));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
