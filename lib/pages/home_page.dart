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
  late String selectedImage;

  final Random random = Random();

  @override
  void initState() {
    super.initState();
    selectedImage = images[random.nextInt(images.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [Image.asset(selectedImage, fit: BoxFit.cover)],
      ),
    );
  }
}
