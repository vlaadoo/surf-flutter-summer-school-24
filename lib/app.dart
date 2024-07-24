// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/domain/theme_controller.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/ui/theme_builder.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/gallery/gallery_screen.dart';
import 'package:surf_flutter_summer_school_24/res/theme/theme_data.dart';

class MyApp extends StatelessWidget {
  final ThemeController themeController;
  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return ThemeInherited(
      themeController: themeController,
      child: ThemeBuilder(
        builder: (_, themeMode) {
          return MaterialApp(
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            themeMode: themeMode,
            home: GalleryScreen(),
            // home: GalleryPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
