import 'dart:convert';
import 'dart:math';

import 'package:daily_quote_app/models/quote_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
  late String _selectedImage;

  final Random random = Random();

  List<QuoteModel> _quotes = [];

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _selectedImage = images[random.nextInt(images.length)];
    getRandomQuotes();
  }

  Future<void> getRandomQuotes() async {
    final Uri url = Uri.https("zenquotes.io", "/api/quotes");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var i in data) {
          final QuoteModel quote = QuoteModel(quote: i["q"], author: i["a"]);
          _quotes.add(quote);
        }
        setState(() {});
      }
    } catch (e) {
      print("Error fetching quotes: $e");
      // Display a snackbar or error message to the user
    }
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
            image: AssetImage(_selectedImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child:
              _quotes.isEmpty
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.format_quote,
                        size: 100.0,
                        color: Colors.white,
                      ),
                      Text(
                        _quotes[_index].quote,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 6.0),
                          Text(
                            _quotes[_index].author,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_index < _quotes.length - 1) {
                                setState(() {
                                  _index++;
                                });
                              } else {
                                _quotes = [];
                                _index = 0;
                                getRandomQuotes();
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.restart_alt,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                          SizedBox(width: 12.0),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
