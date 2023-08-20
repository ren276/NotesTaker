import 'package:flutter/material.dart';

import 'package:forms/constants/routes.dart';
import 'package:forms/services/auth/AuthService.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Email'),),
      body: Column(
        children: [
          const Text("We've sent you an email verification. Please open it to verify your account !"),
          const Text("If you haven't recieved your verification email yet, press thee button below !"),
          TextButton(onPressed: () async {
             AuthService.firebase().sendEmailVerification();

          }, child: const Text('Send Email verification')),
          TextButton(onPressed: ()async{
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }
              , child:Text('Restart'))
        ],
      ),
    );
  }
}

