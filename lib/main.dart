import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/app.dart';
import 'package:surf_flutter_summer_school_24/di/app_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appScope = await AppScope.init(
    child: const MyApp(),
  );
  runApp(appScope);
}
