import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/error_screen.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/gallery/widgets/grid_view_widget.dart';
import 'gallery_wm.dart';
import '../../../models/picture.dart';

class GalleryScreen extends ElementaryWidget<IGalleryWidgetModel> {
  const GalleryScreen({Key? key}) : super(createGalleryWidgetModel, key: key);

  @override
  Widget build(IGalleryWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: wm.screenWidth / 2.5,
          child: ColorFiltered(
            colorFilter: Theme.of(wm.context).brightness == Brightness.dark
                ? const ColorFilter.matrix(<double>[
                    -1,
                    0,
                    0,
                    0,
                    255,
                    0,
                    -1,
                    0,
                    0,
                    255,
                    0,
                    0,
                    -1,
                    0,
                    255,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ])
                : const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.multiply,
                  ),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              wm.showModalBottom(
                context: wm.context,
                onUploadPhoto: wm.uploadImage,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: wm.updatePage,
          child: EntityStateNotifierBuilder<List<Picture>>(
            listenableEntityState: wm.picturesState,
            loadingBuilder: (_, __) => const Center(
                child: CircularProgressIndicator(
              color: Colors.cyan,
            )),
            errorBuilder: (_, e, __) =>
                ErrorScreen(onRetryPressed: wm.onRetryPressed),
            builder: (_, pictures) {
              if (pictures == null || pictures.isEmpty) {
                return const Center(child: Text('No pictures available'));
              }

              return GridViewWidget(photos: pictures, wm: wm);
            },
          ),
        ),
      ),
    );
  }
}
