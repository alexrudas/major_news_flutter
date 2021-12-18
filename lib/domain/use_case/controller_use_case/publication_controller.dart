import 'package:app_majpr_new/domain/models/publication_model.dart';
import 'package:app_majpr_new/domain/use_case/publication_manager.dart';
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
  Future<void> addPublication(
      {uid, section, date, title, message, userName}) async {
    var publicationModel = PublicationModel(
        uid: uid,
        section: section,
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
}
