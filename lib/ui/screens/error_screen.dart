// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRetryPressed;
  ErrorScreen({super.key, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_tethering_error,
            size: 100,
          ),
          Text(
            'Упс!',
            style: TextStyle(
              fontSize: 36,
            ),
          ),
          Text(
            "Произошла ошибка.\nПопробуйте позже.",
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
            ),
            onPressed: onRetryPressed,
            child: Text(
              "ПОПРОБОВАТЬ СНОВА",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
