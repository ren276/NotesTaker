import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forms/views/LoginView.dart';
import 'package:forms/views/RegisterView.dart';
import 'package:forms/views/VerifyEmailView.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



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
      '/login/' : (context)=>const LoginView(),
      '/register/' : (context)=>const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future:
    Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform,),
      builder:(context,snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
           final user = FirebaseAuth.instance.currentUser;
           if (user != null) {
             if (user.emailVerified){
               print('Email is Verified');

             }else {
               return const VerifyEmailView();
           }

           } else {
             return const LoginView();
           }
            return const Text('Done');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
