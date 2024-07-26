import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/ui/widgets/error_widget.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/ui/widgets/grid_view_widget.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/ui/widgets/loading_widget.dart';
import 'gallery_wm.dart';
import '../models/picture.dart';

class GalleryScreen extends ElementaryWidget<IGalleryWidgetModel> {
  GalleryScreen({Key? key}) : super(createGalleryWidgetModel, key: key);

  @override
  Widget build(IGalleryWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: wm.screenWidth / 2.5,
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(wm.context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              BlendMode.srcIn,
            ),
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
          child: GestureDetector(
            onScaleUpdate: (details) {
              final now = DateTime.now();
              if (now.difference(wm.lastScaleChange).inMilliseconds > 500) {
                if (details.scale > 1.0) {
                  wm.decreaseColumns();
                } else if (details.scale < 1.0) {
                  wm.increaseColumns();
                }
                wm.updateLastScaleChangeTime(now);
              }
            },
            child: EntityStateNotifierBuilder<List<Picture>>(
                listenableEntityState: wm.picturesState,
                loadingBuilder: (_, __) => const CustomLoadingWidget(),
                errorBuilder: (_, e, __) =>
                    CustomErrorWidget(onRetryPressed: wm.onRetryPressed),
                builder: (_, pictures) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: pictures == null || pictures.isEmpty
                        ? const CustomLoadingWidget()
                        : GridViewWidget(photos: pictures, wm: wm),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
