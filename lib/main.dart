import 'package:flutter/material.dart';
import 'package:forms/constants/routes.dart';
import 'package:forms/services/auth/AuthService.dart';
import 'package:forms/views/LoginView.dart';
import 'package:forms/views/NotesView.dart';
import 'package:forms/views/RegisterView.dart';
import 'package:forms/views/VerifyEmailView.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Notes taker',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context)=> const NotesView(),
      verifyEmailRoute: (context)=> const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}


