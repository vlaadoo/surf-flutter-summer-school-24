import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/constants.dart';
import 'package:surf_flutter_summer_school_24/ui/gallery/widgets/bottom_modal_widget.dart';
import 'package:surf_flutter_summer_school_24/ui/gallery/widgets/grid_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: ColorFiltered(
            colorFilter: Theme.of(context).brightness == Brightness.dark
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
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetWidget();
                  });
            },
          ),
        ],
      ),
      body: SafeArea(child: GridViewWidget(photos: myPhotos)),
    );
  }
}
