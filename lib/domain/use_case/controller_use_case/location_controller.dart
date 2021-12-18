import 'package:app_majpr_new/domain/models/location_model.dart';
import 'package:app_majpr_new/domain/use_case/location_manager.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  // Observables
  final _location = Rx<MyLocation?>(null);
  late LocationManager _manager;

  set locationManager(LocationManager manager) {
    _manager = manager;
  }

  set location(MyLocation? myLocation) {
    _location.value = myLocation;
  }

  // Getters
  LocationManager get manager => _manager;

  MyLocation? get location => _location.value;

  Rx<MyLocation?> get reactiveLocation => _location;
}
