import 'dart:developer';

import 'package:app_majpr_new/data/repositories_data/chat_repo_data/realtime_database.dart';
import 'package:app_majpr_new/data/services_data/location.dart';
import 'package:app_majpr_new/domain/models/location_model.dart';
import 'package:app_majpr_new/domain/services_domain/storage_services.dart';
import 'package:app_majpr_new/domain/use_case/auth_management.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/authentication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/connectivity_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/location_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/notification_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/permissions_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/publication_controller.dart';
import 'package:app_majpr_new/domain/use_case/controller_use_case/state_controller.dart';
import 'package:app_majpr_new/domain/use_case/location_manager.dart';
import 'package:app_majpr_new/domain/use_case/permission_manager.dart';
import 'package:app_majpr_new/domain/use_case/theme_manager.dart';
import 'package:app_majpr_new/ui/my_app.dart';
import 'package:app_majpr_new/ui/pages/authentication/firebase_conection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:workmanager/workmanager.dart';
import 'domain/use_case/publication_manager.dart';
import 'domain/use_case/status_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    updatePositionInBackground,
    isInDebugMode: true,
  );
  await Firebase.initializeApp();
  Get.put(PublicationManager());
  Get.put(PublicationController());
  Get.put(FirestoreDatabase());
  Get.put(AuthManagement());
  final authController = Get.put(AuthenticationController());
  Get.put(StatusManager());
  Get.put(StateController());
  Get.put(LocationController());
  Get.put(ThemeManager());
  Get.put(RealTimeChat());
  PermissionsController permissionsController =
      Get.put(PermissionsController());
  permissionsController.permissionManager = PermissionManager();
  ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  // Connectivity stream
  Connectivity().onConnectivityChanged.listen((connectivityStatus) {
    log("connection changed");
    connectivityController.connectivity = connectivityStatus;
  });

  Get.put(LocationController());
  // Notification controller
  NotificationController notificationController =
      Get.put(NotificationController());
  notificationController.initialize();

  Get.put(NotificationController());

  authController.getLoggedUser();

  ThemeManager themeManager = Get.find();
  themeManager.storedTheme.then((isDark) {
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  });

  runApp(MyApp());
}

void updatePositionInBackground() async {
  final manager = LocationManager();
  final service = LocationService();
  Workmanager().executeTask((task, inputData) async {
    final position = await manager.getCurrentLocation();
    final details = await manager.retrieveUserDetails();
    var location = MyLocation(
        name: details['name']!,
        id: details['uid']!,
        lat: position.latitude,
        long: position.longitude);
    await service.fecthData(
      map: location.toJson,
    );
    log("updated location background"); //simpleTask will be emitted here.
    print("updated location background"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instanciar la clase para conectar las rutas hijas (login, etc.)

    Get.put(FirebaseConection());
    return MyApp();
  }
}
