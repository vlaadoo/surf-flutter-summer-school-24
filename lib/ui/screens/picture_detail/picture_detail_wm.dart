import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/models/picture.dart';
import 'package:surf_flutter_summer_school_24/ui/screens/picture_detail/picture_detail_screen.dart';
import 'picture_detail_model.dart';

PictureDetailWidgetModel createPictureDetailWidgetModel(
    BuildContext context, PictureDetailModel model) {
  return PictureDetailWidgetModel(model);
}

abstract class IPictureDetailWidgetModel implements IWidgetModel {
  List<Picture> get pictures;
  PageController get pageController;
  ValueNotifier<int> get currentPageNotifier;
  get context;

  void goBack() {}
}

class PictureDetailWidgetModel
    extends WidgetModel<PictureDetailScreen, PictureDetailModel>
    implements IPictureDetailWidgetModel {
  late final PageController _pageController;
  final ValueNotifier<int> _currentPageNotifier;

  PictureDetailWidgetModel(PictureDetailModel model)
      : _currentPageNotifier = ValueNotifier<int>(model.initialIndex),
        super(model) {
    _pageController = PageController(
      initialPage: model.initialIndex,
      viewportFraction: 0.8,
    );
    _pageController.addListener(() {
      _currentPageNotifier.value = _pageController.page!.round();
    });
  }

  @override
  List<Picture> get pictures => model.pictures;

  @override
  PageController get pageController => _pageController;

  @override
  ValueNotifier<int> get currentPageNotifier => _currentPageNotifier;

  @override
  get context;

  @override
  void goBack() {
    Navigator.of(context).pop();
  }
}
