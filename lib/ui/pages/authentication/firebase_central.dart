import 'package:app_majpr_new/ui/pages/authentication/login/login.dart';
import 'package:app_majpr_new/ui/pages/content/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseCentral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return Login();
        }
      },
    );
  }
}
