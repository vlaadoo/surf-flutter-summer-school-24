import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Три столбца
          mainAxisSpacing: 5,
          crossAxisSpacing: 3,
          childAspectRatio: 1.0, // Соотношение сторон для равных ячеек
        ),
        itemCount: 21, // 3x7
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[300],
          );
        },
      ),
    );
  }
}
