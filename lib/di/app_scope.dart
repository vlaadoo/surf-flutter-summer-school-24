import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/repositories/picture_repository.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/data/theme_repository.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/domain/theme_controller.dart';
import 'package:surf_flutter_summer_school_24/storage/theme/theme_storage.dart';

class AppScope extends InheritedWidget {
  final PictureRepository pictureRepository;
  final ThemeController themeController;

  const AppScope({
    super.key,
    required this.pictureRepository,
    required this.themeController,
    required super.child,
  });

  static AppScope of(BuildContext context) {
    final AppScope? result =
        context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(result != null, 'No AppScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) {
    return pictureRepository != oldWidget.pictureRepository ||
        themeController != oldWidget.themeController;
  }

  static Future<AppScope> init({required Widget child}) async {
    final prefs = await SharedPreferences.getInstance();
    final themeStorage = ThemeStorage(prefs: prefs);
    final themeRepository = ThemeRepository(themeStorage: themeStorage);
    final themeController = ThemeController(themeRepository: themeRepository);
    final pictureRepository = PictureRepository(
      yaToken: "token",
    );

    return AppScope(
      pictureRepository: pictureRepository,
      themeController: themeController,
      child: child,
    );
  }
}
