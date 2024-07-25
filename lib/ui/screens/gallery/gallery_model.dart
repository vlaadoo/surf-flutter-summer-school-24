import 'package:elementary/elementary.dart';
import '../../../models/picture.dart';
import '../../../repositories/picture_repository.dart';

class GalleryModel extends ElementaryModel {
  final PictureRepository _pictureRepository;

  GalleryModel(this._pictureRepository, double width);

  Future<List<Picture>> fetchPictures() {
    return _pictureRepository.getPictures();
  }

  Future<void> uploadPicture() {
    return _pictureRepository.uploadImageToYandexCloud();
  }

  Future<void> deletePicture(String name) async {
    return await _pictureRepository.deleteImage(name);
  }
}
