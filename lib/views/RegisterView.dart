import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
import 'package:forms/constants/routes.dart';

import '../utilities/ShowErrorDialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter Email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter Password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try{
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: email, password: password);
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch(e){
                if(e.code=='weak-password'){
                  await showErrorDialog(context, 'Weak Password');
                } else if(e.code=='email-already-in-use') {
                  await showErrorDialog(context, 'Email already in use');
                } else if (e.code=='invalid-email'){
                  await showErrorDialog(context, 'Invalid Email');
                } else{
                  await showErrorDialog(context, 'Error: ${e.code}');
                }
              } catch (e){
                await showErrorDialog(context, e.toString(),);
              }
            },
            child: const Text('Register'),
          ),
          TextButton(onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
          },
              child: Text("Already Registered ? Login Here !")),
        ],
      ),
    );
  }
}

