
import 'package:flutter/material.dart';
import 'package:forms/services/auth/AuthService.dart';
import '../constants/routes.dart';
import '../enums/MenuAction.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value){
              case MenuAction.logout:
                final shouldLogout=await showLogOutDialog(context);
                if (shouldLogout){
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
                break;
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('LogOut'),
              )
            ];
          })
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      //we use  then here because it can or cannot return a bool value or even a value
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out??'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
