import 'package:daily_quote_app/boxes.dart';
import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite quotes"), centerTitle: true),
      body: ListView.builder(
        itemCount: favQuotesBox.length,
        itemBuilder: (context, index) {
          final FavoriteQuoteModel favQuote = favQuotesBox.getAt(index);
          return ListTile(title: Text(favQuote.quote));
        },
      ),
    );
  }
}
