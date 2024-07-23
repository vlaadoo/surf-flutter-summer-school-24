import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridViewWidget extends StatelessWidget {
  final List<String> photos;
  const GridViewWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      cacheExtent: 50,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 3,
      ),
      itemCount: photos.length,
      itemBuilder: (BuildContext ctx, index) {
        return Stack(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: "assets/images/placeholder.png",
              image: photos[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        );
      },
    );
  }
}
