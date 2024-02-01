import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Screens/login.dart';

import '../firebase/firebaseservice.dart';

class RegUsers extends StatefulWidget {
  const RegUsers({super.key});

  @override
  State<RegUsers> createState() => _RegUsersState();
}

class _RegUsersState extends State<RegUsers> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirestoreService fbService = FirestoreService(); //object

  final fireauth = FirebaseAuth.instance;
  // TextEditingController email = TextEditingController();
  // TextEditingController pass = TextEditingController();

  void regUser() async {
    try {
      fireauth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passController.text)
          .then((value) {});
    } on Exception catch (e) {
      if (kDebugMode) {
        print("reg exception: $e");
      }
    }
  }

  final formKey = GlobalKey<FormState>();

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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: "Email"),
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        final bool isValid =
                            EmailValidator.validate(value.toString());
                        return isValid ? null : "Enter a valid Email";
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        // Perform custom password validation here
                        if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return "Password must contain at least one uppercase letter";
                        }
                        if (!value.contains(RegExp(r'[a-z]'))) {
                          return "Password must contain at least one lowercase letter";
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return "Password must contain at least one numeric character";
                        }
                        if (!value
                            .contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                          return "Password must contain at least one special character";
                        }

                        return null; // Password is valid
                      },
                      decoration: const InputDecoration(hintText: "Password"),
                      controller: passController,
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // if (passController.text != "" && emailController.text != "") {
                //     //   if (formKey.currentState!.validate()) {
                //     // fbService.regUser(
                //     //     emailController.text, passController.text);
                //     regUser();
                //     //     } else {
                //     //       print("validation error");
                //     //     }
                //     //   } else {
                //     //     print("Enterdata");
                //     //   }
                //   },
                //   child: const Text("Register"),
                // ),
                ElevatedButton(
                  onPressed: () {
                    regUser();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginUsers(),
                    ));
                  },
                  child: const Text("Register"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
