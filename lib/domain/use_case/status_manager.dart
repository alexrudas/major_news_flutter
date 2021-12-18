import 'package:app_majpr_new/data/repositories_data/firestore_database.dart';
import 'package:app_majpr_new/domain/models/state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusManager {
  final _database = FirestoreDatabase();

  Future<void> sendStatus(StateModel status) async {
    await _database.add(collectionPath: "state", data: status.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getstateStream() {
    return _database.listenCollection(collectionPath: "state");
  }

  Future<List<StateModel>> getstateOnce() async {
    final stateData = await _database.readCollection(collectionPath: "state");
    return _extractInstances(stateData);
  }

  List<StateModel> extractstate(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final stateData = _database.extractDocs(snapshot);
    return _extractInstances(stateData);
  }

  Future<void> removeStatus(StateModel status) async {
    await _database.deleteDoc(collectionPath: "state", id: status.id!);
  }

  List<StateModel> _extractInstances(List<Map<String, dynamic>> data) {
    List<StateModel> state = [];
    for (var statusJson in data) {
      state.add(StateModel.fromJson(statusJson));
    }
    return state;
  }
}
