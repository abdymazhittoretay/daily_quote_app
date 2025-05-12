import 'package:daily_quote_app/boxes.dart';
import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:daily_quote_app/provider/favorite_quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite quotes"), centerTitle: true),
      body: Consumer<FavoriteQuoteProvider>(
        builder: (context, favQuoteProvider, child) {
          if (favQuotesBox.isEmpty) {
            return Center(
              child: Text(
                "There are no favorites yet.",
                style: TextStyle(fontSize: 16.0),
              ),
            );
          }
          return ListView.builder(
            itemCount: favQuotesBox.length,
            itemBuilder: (context, index) {
              final FavoriteQuoteModel favQuote = favQuotesBox.getAt(index);
              return ListTile(
                title: Text(favQuote.quote),
                trailing: IconButton(
                  onPressed: () {
                    favQuoteProvider.addRemoveQuote(favQuote);
                  },
                  icon:
                      favQuoteProvider.isFavorite(favQuote)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
