import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    "images/1_image.jpg",
    "images/2_image.jpg",
    "images/3_image.jpg",
    "images/4_image.jpg",
    "images/5_image.jpg",
    "images/6_image.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final String selectedImage = images[Random().nextInt(images.length)];
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [Image.asset(selectedImage, fit: BoxFit.cover)],
      ),
    );
  }
}
