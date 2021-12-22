import 'package:app_majpr_new/domain/models/state_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/status_manager.dart';
import 'package:get/get.dart';

class StateController extends GetxController {
  StateController() {
    getStatus();
  }
  getStatus() async {
    listState.value = await statusManager.getstateOnce();
  }

  StatusManager statusManager = Get.find();
  var listState = [].obs; //lista vacia observable
  Future<void> addState({uid, userName, message, avatarLink, date}) async {
    var stateModel = StateModel(
        uid: uid,
        userName: userName,
        avatarLink: avatarLink,
        date: date.toString(),
        message: message);
    listState.add(stateModel);
    try {
      await statusManager.sendStatus(stateModel);
    } catch (e) {
      return Future.error(e);
    }
  }

  // Este código muestra en la vista de estados, Mi Último Estado
  var _lastState = "".obs; // se crea una variable observable
  String get lastState => _lastState.value; // Método para enviar el dato

  var _lastDate = "".obs;
  String get lastDate => _lastDate.value;

  // Este método muestra él último estado desde el firebase
  getLastState() {
    AuthenticationController authenticationController = Get.find();
    var myState = listState
        .where((stateModel) =>
            stateModel.uid == authenticationController.userActive!.id)
        .toList();
    if (myState.isNotEmpty) {
      _lastState.value = myState[myState.length - 1].message;
      _lastDate.value = myState[myState.length - 1].date;
    }
  }

  guardarEstado(String miEstado, String fecha) {
    _lastState.value = miEstado;
    _lastDate.value = fecha;
  }
}
