import 'package:app_majpr_new/data/repositories_data/firestore_database.dart';
import 'package:app_majpr_new/domain/models/publication_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicationManager {
  final _database = FirestoreDatabase();
  final _firestore = FirebaseFirestore.instance;

  Future<void> sendPublication(PublicationModel publication) async {
    await _database.add(
        collectionPath: "publication", data: publication.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getpublicationStream() {
    return _database.listenCollection(collectionPath: "publication");
  }

  Future<List<PublicationModel>> getpublicationOnce() async {
    final publicationData =
        await _database.readCollection(collectionPath: "publication");
    return _extractInstances(publicationData);
  }

  List<PublicationModel> extractpublication(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    final publicationData = _database.extractDocs(snapshot);
    return _extractInstances(publicationData);
  }

  // Future<void> removeStatus(PublicationModel status) async {
  //   await _database.deleteDoc(documentPath: status.dbRef!);
  // }

  // Future<void> rejectPublication(String publicationId) {
  //   return _firestore
  //       .collection('publication')
  //       .document(publicationId)
  //       .delete();
  //}

  List<PublicationModel> _extractInstances(List<Map<String, dynamic>> data) {
    List<PublicationModel> publication = [];
    for (var statusJson in data) {
      publication.add(PublicationModel.fromJson(statusJson));
    }
    return publication;
  }
}
