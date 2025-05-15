import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:daily_quote_app/provider/favorite_quote_provider.dart';
import 'package:daily_quote_app/provider/quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(context.watch<QuoteProvider>().selectedImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Text("Favorite quotes"),
          centerTitle: true,
        ),
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
            final List<dynamic> favQuotes = favQuotesBox.values.toList();

            favQuotes.sort((a, b) => b.dateTime.compareTo(a.dateTime));

            return ListView.builder(
              itemCount: favQuotes.length,
              itemBuilder: (context, index) {
                final FavoriteQuoteModel favQuote = favQuotes[index];
                return ListTile(
                  textColor: Colors.white,
                  contentPadding: EdgeInsets.only(
                    left: 16.0,
                    right: 8.0,
                    top: 4.0,
                    bottom: 4.0,
                  ),
                  leading: Icon(Icons.format_quote, color: Colors.white),
                  title: Text(favQuote.quote, style: TextStyle(fontSize: 18.0)),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(width: 3.0),
                      Text(
                        favQuote.author,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 16.0,
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
