import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';

class DeleteConfirmationWidget extends StatelessWidget {
  final VoidCallback deletePhoto;

  const DeleteConfirmationWidget({
    super.key,
    required this.deletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text('Отмена'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            title: const Text('УДАЛИТЬ', style: TextStyle(color: Colors.red)),
            onTap: deletePhoto,
          ),
        ],
      ),
    );
  }
}
