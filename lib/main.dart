import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_flutter_summer_school_24/app.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/data/theme_repository.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/domain/theme_controller.dart';
import 'package:surf_flutter_summer_school_24/storage/theme/theme_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeStorage = ThemeStorage(
    prefs: prefs,
  );
  final themeRepository = ThemeRepository(
    themeStorage: themeStorage,
  );
  final themeController = ThemeController(
    themeRepository: themeRepository,
  );

  runApp(MyApp(
    themeController: themeController,
  ));
}
