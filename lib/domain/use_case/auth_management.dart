import 'package:app_majpr_new/data/repositories_data/firestore_database.dart';
import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/services_domain/authentication_service.dart';
import 'package:get/get.dart';

class AuthManagement {
  PasswordAuth get auth => PasswordAuth();

  Future<UserModel?> getLoggedUser() async {
    return await auth.getLoggedUser();
  }

  Future<UserModel?> signIn(
      {required String email, required String password}) async {
    try {
      return await auth.signIn(email: email, password: password);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<UserModel>> extractAllUsers() async {
    try {
      List<UserModel> users = [];
      FirestoreDatabase database = FirestoreDatabase();
      var doc = await database.readCollection(collectionPath: 'users');
      print('extractAllUsers ' + doc.length.toString());
      for (var user in doc) {
        users.add(UserModel.fromMap(user['data']));
      }
      return users;
    } catch (e) {
      print('AuthManagement extractAllUsers error');
      return Future.error(e);
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    //this.dbRef,
  }) async {
    try {
      var user = UserModel(
          userName: name,
          email: email,
          password: password,
          avatarLink:
              'https://media.admagazine.com/photos/618a6acbcc7069ed5077ca7f/master/w_1600%2Cc_limit/68704.jpg');
      auth.signUp(userModel: user);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
