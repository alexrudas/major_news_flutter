import 'package:app_majpr_new/domain/services_domain/location.dart';
import 'package:geolocator/geolocator.dart';

class GpsService implements LocationInterface {
  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
