import 'package:app_majpr_new/data/repositories_data/shared_preferences_data_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeManager {
  final _sharedPreferences = LocalPreferences();

  Future<void> changeTheme(bool isDarkMode) async {
    // Before change the theme we store the preference
    await _sharedPreferences.storeData<bool>('DarkTheme', isDarkMode);
    // We change the subject accordingly
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    //print(Get.isDarkMode);
  }

  // If there isn't any stored preference we set it to the current mode
  Future<bool> get storedTheme async =>
      await _sharedPreferences
          .retrieveData<bool>('DarkTheme') ?? // retrieveData recupera el dato
      Get.isDarkMode;
}
