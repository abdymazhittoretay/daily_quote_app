import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:daily_quote_app/provider/favorite_quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite quotes"), centerTitle: true),
      body: Consumer<FavoriteQuoteProvider>(
        builder: (context, favQuoteProvider, child) {
          final Box favQuotesBox = favQuoteProvider.favQuotesBox;
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
                contentPadding: EdgeInsets.only(
                  left: 16.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                title: Text(favQuote.quote, style: TextStyle(fontSize: 18.0)),
                subtitle: Text(
                  favQuote.author,
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                trailing: IconButton(
                  onPressed: () {
                    favQuoteProvider.addRemoveQuote(favQuote);
                  },
                  iconSize: 30.0,
                  color: Colors.red,
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
