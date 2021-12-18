import 'dart:developer';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/services_domain/storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PasswordAuth {
  // Este Método obtiene el usuario cuando ya ha iniciado la sesión
  getLoggedUser() async {
    var user = FirebaseAuth.instance.currentUser;
    FirestoreDatabase firestoreDatabase = Get.find();
    if (user != null) {
      try {
        var doc =
            await firestoreDatabase.readDoc(documentPath: "users/${user.uid}");
        if (doc != null) {
          return UserModel.fromMap(doc);
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
  }

  Future<UserModel?> signIn(
      {required String email, required String password}) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirestoreDatabase firestoreDatabase = Get.find();
      var doc = await firestoreDatabase.readDoc(
          documentPath: "users/${userCredential.user!.uid}");
      if (doc != null) {
        return UserModel.fromMap(doc);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp({required UserModel userModel}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password);
      userCredential.user!.updateDisplayName(userModel.userName);
      FirestoreDatabase firestoreDatabase = Get.find();

      Map<String, dynamic> doc = userModel.toMap();
      doc.addAll({'id': userCredential.user!.uid});

      firestoreDatabase.addWithID(
          collectionPath: 'users', data: doc, idDoc: userCredential.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Contraseña insegura",
          "La seguridad de la contraseña es muy débil",
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Email inválido",
          "Ya existe un usuario con este correo electrónico.",
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
