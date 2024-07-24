// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/picture_detail/picture_detail_model.dart';
import '../../../models/picture.dart';
import 'picture_detail_wm.dart';

class PictureDetailScreen extends ElementaryWidget<IPictureDetailWidgetModel> {
  final List<Picture> pictures;
  final int initialIndex;

  PictureDetailScreen({
    Key? key,
    required this.pictures,
    required this.initialIndex,
  }) : super(
            (context) => createPictureDetailWidgetModel(
                context, PictureDetailModel(pictures, initialIndex)),
            key: key);

  @override
  Widget build(IPictureDetailWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            wm.goBack();
          },
        ),
        title: ValueListenableBuilder<int>(
          valueListenable: wm.currentPageNotifier,
          builder: (context, currentIndex, _) {
            return Text(pictures[wm.currentPageNotifier.value].date);
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<int>(
              valueListenable: wm.currentPageNotifier,
              builder: (context, currentIndex, _) {
                return Text(
                  '${currentIndex + 1}/${pictures.length}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: wm.pageController,
        itemCount: pictures.length,
        itemBuilder: (context, index) {
          final picture = pictures[index];
          return ValueListenableBuilder<int>(
            valueListenable: wm.currentPageNotifier,
            builder: (context, currentIndex, child) {
              double scale =
                  (wm.currentPageNotifier.value == index) ? 1.05 : 0.9;
              return TweenAnimationBuilder(
                tween: Tween(begin: scale, end: scale),
                duration: Duration(milliseconds: 350),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: ClipRRect(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(picture.imageUrl,
                                fit: BoxFit.contain),
                            if (wm.currentPageNotifier.value != index)
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: Colors.black.withOpacity(0),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
              // return Center(
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 16),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(16),
              //             child:
              //                 Image.network(picture.imageUrl, fit: BoxFit.contain),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
