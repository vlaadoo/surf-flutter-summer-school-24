import 'package:elementary/elementary.dart';
import 'package:surf_flutter_summer_school_24/repositories/picture_repository.dart';

class AppScope extends ElementaryModel {
  final PictureRepository pictureRepository;

  AppScope({required this.pictureRepository});
}

AppScope appScope = AppScope(
  pictureRepository: PictureRepository(apiUrl: 'http://10.7.1.11:3000/'),
);
