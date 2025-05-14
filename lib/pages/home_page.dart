import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:daily_quote_app/pages/favorites_page.dart';
import 'package:daily_quote_app/provider/favorite_quote_provider.dart';
import 'package:daily_quote_app/provider/quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, child) {
        final quote = quoteProvider.quote;
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(quoteProvider.selectedImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
              actions: [
                InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Favorites",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(width: 6.0),
                        Icon(Icons.favorite, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child:
                  quoteProvider.isLoading || quote == null
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
                          SelectableText(
                            cursorWidth: 0.0,
                            quote.quote.isEmpty
                                ? "For some reason there is no quote! I am sorry!"
                                : quote.quote,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person, color: Colors.white),
                              SizedBox(width: 6.0),
                              SelectableText(
                                cursorWidth: 0.0,
                                quote.author.isEmpty ? "Unknown" : quote.author,
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
                                  quoteProvider.nextQuote();
                                },
                                icon: Icon(
                                  Icons.restart_alt,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                              SizedBox(width: 12.0),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<FavoriteQuoteProvider>()
                                      .addRemoveQuote(
                                        FavoriteQuoteModel(
                                          quote: quote.quote,
                                          author: quote.author,
                                          dateTime: DateTime.now(),
                                        ),
                                      );
                                },
                                icon: Icon(
                                  context
                                          .watch<FavoriteQuoteProvider>()
                                          .isFavorite(
                                            FavoriteQuoteModel(
                                              quote: quote.quote,
                                              author: quote.author,
                                              dateTime: DateTime.now(),
                                            ),
                                          )
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      context
                                              .watch<FavoriteQuoteProvider>()
                                              .isFavorite(
                                                FavoriteQuoteModel(
                                                  quote: quote.quote,
                                                  author: quote.author,
                                                  dateTime: DateTime.now(),
                                                ),
                                              )
                                          ? Colors.red
                                          : Colors.white,
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
      },
    );
  }
}
