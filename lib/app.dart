import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/ui/theme_builder.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/ui/gallery_screen.dart';
import 'package:surf_flutter_summer_school_24/res/theme/theme_data.dart';
import 'package:surf_flutter_summer_school_24/di/app_scope.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = AppScope.of(context).themeController;
    return ThemeInherited(
      themeController: themeController,
      child: ThemeBuilder(
        builder: (_, themeMode) {
          return MaterialApp(
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            themeMode: themeMode,
            home: GalleryScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
        controller: themeController,
      ),
    );
  }
}
