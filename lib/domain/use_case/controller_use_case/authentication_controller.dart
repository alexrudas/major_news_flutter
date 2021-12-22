import 'package:app_majpr_new/domain/models/user_model.dart';
import 'package:app_majpr_new/domain/use_case/auth_management.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
//variables observarbles
  var isLogged = false.obs; //variable observable (obs)
  final _userActive = Rx<UserModel?>(null);
  AuthManagement authManagement = Get.find();
  late Rx<dynamic> _uid = "".obs;
  late Rx<dynamic> _name = "".obs;
  late Rx<dynamic> _photo = "".obs;

  UserModel? get userActive => _userActive.value;
  String get uid => _uid.value;
  String get name => _name.value;
  String get photo => _photo.value;

//Este es el contructor de la clase y  llama al getLoggedUser
  AuthenticationController() {
    getLoggedUser();
  }

  // Este Método trae la info del usuario cuando el usuario tiene una sesión activa
  getLoggedUser() async {
    _userActive.value = await authManagement.getLoggedUser();
    if (_userActive.value != null) {
      isLogged.value = true;
    }
  }

  Future<List<UserModel>> extractAllUser() async {
    print('extractAllUser');
    try {
      return await authManagement.extractAllUsers();
    } catch (e) {
      print('extractAllUser error ' + e.toString());
      return Future.error(e);
    }
  }

//crea los métodos login, logout y signup
  Future<void> login(email, password) async {
    try {
      _userActive.value =
          await authManagement.signIn(email: email, password: password);
      _uid.value = userActive!.id;
      _name.value = userActive!.userName;
      _photo.value =
          'https://noverbal.es/uploads/blog/rostro-de-un-criminal.jpg';
      if (_userActive.value != null) {
        isLogged.value = true;
      }
    } catch (e) {
      return Future.error(e);
    }
    printInfo(info: 'Ok');
  }

  void logout() async {
    await authManagement.signOut();
    isLogged.value = false; // el estado cambia al momento de salir (signUp)
  }

  Future<void> signup({email, password, userName}) async {
    //Este signup es del contrlador
    try {
      await authManagement.signUp(
          // Este signUp se comunica con el authManagement
          email: email,
          password: password,
          name: userName);
      _uid.value = userActive!.id;
      _name.value = userActive!.userName;
      _photo.value =
          'https://noverbal.es/uploads/blog/rostro-de-un-criminal.jpg';
    } catch (e) {
      return Future.error(e);
    }
  }
}
