import 'dart:convert';
import 'dart:math';

import 'package:daily_quote_app/models/quote_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteProvider extends ChangeNotifier {
  QuoteProvider() {
    selectRandomImage();
    getRandomQuotes();
  }

  final List<String> images = [
    "images/1_image.jpg",
    "images/2_image.jpg",
    "images/3_image.jpg",
    "images/4_image.jpg",
    "images/5_image.jpg",
    "images/6_image.jpg",
  ];
  late String _selectedImage;

  final Random random = Random();

  List<QuoteModel> _quotes = [];

  int _index = 0;

  QuoteModel? get quote => _quotes.isEmpty ? null : _quotes[_index];
  String get selectedImage => _selectedImage;
  int get index => _index;

  void selectRandomImage() {
    _selectedImage = images[random.nextInt(images.length)];
    notifyListeners();
  }

  Future<void> getRandomQuotes() async {
    _quotes = [];
    _index = 0;
    final Uri url = Uri.https("zenquotes.io", "/api/quotes");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var i in data) {
          final QuoteModel quote = QuoteModel(quote: i["q"], author: i["a"]);
          _quotes.add(quote);
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching quotes: $e");
    }
  }
}
