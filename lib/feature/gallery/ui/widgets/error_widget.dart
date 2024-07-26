import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRetryPressed;
  const CustomErrorWidget({super.key, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_tethering_error,
            size: 100,
          ),
          const Text(
            'Упс!',
            style: TextStyle(
              fontSize: 36,
            ),
          ),
          const Text(
            "Произошла ошибка.\nПопробуйте позже.",
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
            ),
            onPressed: onRetryPressed,
            child: const Text(
              "ПОПРОБОВАТЬ СНОВА",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
