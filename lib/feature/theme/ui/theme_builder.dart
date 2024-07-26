import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/domain/theme_controller.dart';

typedef ThemeWidgetBuilder = Widget Function(
  BuildContext context,
  ThemeMode themeMode,
);

class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder({
    required this.builder,
    super.key,
    required ThemeController controller,
  });

  final ThemeWidgetBuilder builder;

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeInherited.of(context).themeMode,
      builder: (
        builderContext,
        themeMode,
        _,
      ) =>
          widget.builder(
        builderContext,
        themeMode,
      ),
    );
  }
}
