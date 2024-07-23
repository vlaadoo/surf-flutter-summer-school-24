// photo_page.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  final String photoUrl;
  final bool isCurrentPage;

  const PageViewWidget({
    required this.photoUrl,
    required this.isCurrentPage,
  });

  @override
  Widget build(BuildContext context) {
    double scale = isCurrentPage ? 1.0 : 0.9;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 350),
      tween: Tween(begin: scale, end: scale),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(photoUrl),
                  if (!isCurrentPage)
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
