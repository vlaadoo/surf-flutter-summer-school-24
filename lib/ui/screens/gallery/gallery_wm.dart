import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/di/app_scope.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/gallery/gallery_screen.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/gallery/widgets/bottom_modal_widget.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/gallery/widgets/delete_confirmation_widget.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/picture_detail/picture_detail_screen.dart';
import 'gallery_model.dart';
import '../../../models/picture.dart';

GalleryWidgetModel createGalleryWidgetModel(BuildContext context) {
  return GalleryWidgetModel(
    GalleryModel(appScope.pictureRepository, MediaQuery.of(context).size.width),
    MediaQuery.of(context).size.width,
  );
}

abstract class IGalleryWidgetModel implements IWidgetModel {
  EntityStateNotifier<List<Picture>> get picturesState;

  double get screenWidth;

  BuildContext get context;

  void onPictureTap(List<Picture> pics, int index);

  void showModalBottom(
      {required BuildContext context, required VoidCallback onUploadPhoto});

  void onRetryPressed();

  Future<void> uploadImage();

  Future<void> updatePage();

  Future<void> deletePicture(String name);

  void showDeleteBottom({required VoidCallback deletePhoto});
}

class GalleryWidgetModel extends WidgetModel<GalleryScreen, GalleryModel>
    implements IGalleryWidgetModel {
  final EntityStateNotifier<List<Picture>> _picturesState =
      EntityStateNotifier<List<Picture>>();

  @override
  final double screenWidth;

  GalleryWidgetModel(super.model, this.screenWidth);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadPictures();
  }

  Future<void> _loadPictures() async {
    int maxAttempts = 3;
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        _picturesState.loading();
        final pictures = await model.fetchPictures();
        _picturesState.content(pictures);
        return;
      } catch (e) {
        if (attempt == maxAttempts - 1) {
          _picturesState.error();
        }
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Future<void> uploadImage() {
    return model.uploadPicture();
  }

  @override
  EntityStateNotifier<List<Picture>> get picturesState => _picturesState;

  @override
  void onPictureTap(List<Picture> pics, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PictureDetailScreen(
          pictures: pics,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  void showModalBottom(
      {required BuildContext context, required VoidCallback onUploadPhoto}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWidget(onUploadPhoto: onUploadPhoto);
      },
    );
  }

  @override
  void onRetryPressed() {
    _loadPictures();
  }

  @override
  Future<void> updatePage() {
    return _loadPictures();
  }

  @override
  Future<void> deletePicture(String name) {
    return model.deletePicture(name);
  }

  @override
  void showDeleteBottom({required VoidCallback deletePhoto}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationWidget(deletePhoto: deletePhoto);
      },
    );
  }
}
