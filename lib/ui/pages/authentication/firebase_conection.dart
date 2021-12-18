import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/ui/pages/authentication/firebase_central.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseConection extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  FirebaseConection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase demo - MisionTIC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //print("error ${snapshot.error}");
            return Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // Get.put(FirebaseController());
            Get.put(AuthenticationController());
            // Get.put(ChatController());
            return FirebaseCentral();
          }

          return Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something went wrong")),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Loading")),
    );
  }
}
