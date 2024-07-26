import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/models/picture.dart';
import 'package:surf_flutter_summer_school_24/feature/gallery/ui/gallery_wm.dart';

class GridViewWidget extends StatelessWidget {
  final List<Picture> photos;
  final IGalleryWidgetModel wm;
  const GridViewWidget({super.key, required this.photos, required this.wm});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      cacheExtent: 50,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: wm.columns,
          mainAxisSpacing: 5,
          crossAxisSpacing: 3,
          childAspectRatio: 1),
      itemCount: photos.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            wm.onPictureTap(photos, index);
          },
          onLongPress: () {
            wm.showDeleteBottom(deletePhoto: () {
              wm.deletePicture(photos[index].title);
            });
          },
          child: Stack(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Hero(
                tag: photos[index].hashCode,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder.png",
                  image: photos[index].imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
