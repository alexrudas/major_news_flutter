import 'package:app_majpr_new/data/services_data/location.dart';
import 'package:app_majpr_new/domain/models/location_model.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/connectivity_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/location_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/notification_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/permissions_controller.dart';
import 'package:app_majpr_new/domain/use_case/location_manager.dart';
import 'package:app_majpr_new/ui/pages/content/location/widget_location/location_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class LocationScreen extends StatelessWidget {
  // UsersOffers empty constructor
  LocationScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthenticationController>();
  final permissionsController = Get.find<PermissionsController>();
  final connectivityController = Get.find<ConnectivityController>();
  //final uiController = Get.find<UIController>();
  final locationController = Get.find<LocationController>();
  final notificationController = Get.find<NotificationController>();
  final service = LocationService();

  @override
  Widget build(BuildContext context) {
    final _uid = authController.userActive!.id;
    final _name = authController.userActive!.userName;
    _init(_uid!, _name);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => locationController.location != null
                ? LocationCard(
                    key: const Key("myLocationCard"),
                    title: 'Mi Ubicación',
                    lat: locationController.location!.lat,
                    long: locationController.location!.long,
                    onUpdate: () {
                      if (permissionsController.locationGranted &&
                          connectivityController.connected) {
                        _updatePosition(_uid, _name);
                      }
                    },
                  )
                : const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 3, top: 3),
            child: Text(
              'Cerca de mi',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          // ListView on remaining screen space
          Obx(() {
            if (locationController.location != null) {
              var futureLocations = service.fecthData(
                map: locationController.location!.toJson,
              );
              return FutureBuilder<List<UserLocation>>(
                future: futureLocations,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!;
                    notificationController.show(
                        title: 'Usuarios cera de mi',
                        body:
                            'Hay ${items.length} egresados cerca de tu ubicación...');
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        UserLocation location = items[index];
                        return LocationCard(
                          title: location.name,
                          distance: location.distance,
                        );
                      },
                      // Avoid scrollable inside scrollable
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }

  _init(String uid, String name) {
    if (!permissionsController.locationGranted) {
      permissionsController.manager.requestGpsPermission().then((granted) {
        if (granted) {
          locationController.locationManager = LocationManager();
          _updatePosition(uid, name);
        } else {
          //uiController.screenIndex = 0;
        }
      });
    } else {
      locationController.locationManager = LocationManager();
      _updatePosition(uid, name);
    }
    notificationController.createChannel(
        id: 'users-location',
        name: 'Users Location',
        description: 'Other users location...');
  }

  _updatePosition(String uid, String name) async {
    final position = await locationController.manager.getCurrentLocation();
    await locationController.manager.storeUserDetails(uid: uid, name: name);
    locationController.location = MyLocation(
        name: name, id: uid, lat: position.latitude, long: position.longitude);
    Workmanager().registerPeriodicTask(
      "1",
      "locationPeriodicTask",
    );
  }
}
