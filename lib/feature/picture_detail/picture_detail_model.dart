import 'package:elementary/elementary.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/models/picture.dart';

class PictureDetailModel extends ElementaryModel {
  final List<Picture> pictures;
  final int initialIndex;

  PictureDetailModel(this.pictures, this.initialIndex);
}
