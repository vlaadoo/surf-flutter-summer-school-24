// photo_viewer.dart
import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/constants.dart';
import 'package:surf_flutter_summer_school_24/ui/slider/widgets/page_view_widget.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key});

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  final PageController _controller = PageController(
    viewportFraction: 0.85,
  );

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Действие на нажатие кнопки "Назад"
          },
        ),
        title: const Text('Title'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '${_currentPage + 1}/${myPhotos.length}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: myPhotos.length,
        itemBuilder: (context, index) {
          return PageViewWidget(
            photoUrl: myPhotos[index],
            isCurrentPage: _currentPage == index,
          );
        },
      ),
    );
  }
}
