import 'package:flutter/material.dart';
import 'package:forms/constants/routes.dart';
import 'package:forms/services/auth/AuthService.dart';
import '../services/auth/AuthExceptions.dart';
import '../utilities/ShowErrorDialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: Text('Login'),
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
              try {
                AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  //user email is verified
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  //user not verified email
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, 'User not found');
              } on WrongPasswordAuthException {
                await showErrorDialog(context, 'Wrong password');
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Authentication Error',
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: Text("Not Registered yet ? Register Here !")),
        ],
      ),
    );
  }
}
