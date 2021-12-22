import 'package:app_majpr_new/domain/models/publication_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/publication_manager.dart';
import 'package:app_majpr_new/ui/pages/content/publication/my_publication.dart';
import 'package:get/get.dart';

class PublicationController extends GetxController {
  // muestra la lista de las publicaciones registradas en firebase
  PublicationController() {
    getStatus();
  }
  getStatus() async {
    listPublication.value = await publicationManager.getpublicationOnce();
  } //  fin del código que muestra la lista guardada en firebase

  PublicationManager publicationManager = Get.find();
  var listPublication = [].obs; //lista vacia observable
  Future<void> addPublication({uid, date, title, message, userName}) async {
    var publicationModel = PublicationModel(
        uid: uid,
        date: date,
        title: title,
        message: message,
        userName: userName);
    listPublication.add(publicationModel);
    try {
      await publicationManager.sendPublication(publicationModel);
    } catch (e) {
      return Future.error(e);
    }
  }

// Este código muestra en la vista de estados, Mi Último Estado
  var _lastPublication = "".obs; // se crea una variable observable
  String get lastPublication =>
      _lastPublication.value; // Método para enviar el dato

  var _lastDate = "".obs;
  String get lastDate => _lastDate.value;

  // Este método muestra él último estado desde el firebase
  getlastPublication() {
    AuthenticationController authenticationController = Get.find();
    var myPublication = listPublication
        .where((publicationModel) =>
            publicationModel.uid == authenticationController.userActive!.id)
        .toList();
    if (myPublication.isNotEmpty) {
      _lastPublication.value = myPublication[myPublication.length - 1].message;
      _lastDate.value = myPublication[myPublication.length - 1].date;
    }
  }

  guardarPublicacion(String miPublicacion, String fecha) {
    _lastPublication.value = miPublicacion;
    _lastDate.value = fecha;
  }
}
