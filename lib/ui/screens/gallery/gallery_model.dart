import 'package:elementary/elementary.dart';
import 'package:elementary_helper/src/relations/notifier/entity_state_notifier.dart';
import '../../../models/picture.dart';
import '../../../repositories/picture_repository.dart';

class GalleryModel extends ElementaryModel {
  final PictureRepository _pictureRepository;

  GalleryModel(this._pictureRepository, double width);

  Future<List<Picture>> fetchPictures() {
    return _pictureRepository.getPictures();
  }

  Future<void> uploadPicture(EntityStateNotifier<List<Picture>> picturesState) {
    return _pictureRepository.uploadImageToYandexCloud(picturesState);
  }

  Future<void> deletePicture(
      String name, EntityStateNotifier<List<Picture>> picturesState) async {
    return await _pictureRepository.deleteImage(name, picturesState);
  }
}
