import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.wb_sunny_outlined),
            title: const Text('Тема'),
            trailing: Theme.of(context).brightness == Brightness.dark
                ? Text("Темная")
                : Text("Светлая"),
            onTap: () {
              ThemeInherited.of(context).switchThemeMode();
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud_upload_outlined),
            title: const Text('Загрузить фото...'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
