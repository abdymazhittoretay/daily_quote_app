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
      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(selectedImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Example text",
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
            Text(
              "-Example author",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
