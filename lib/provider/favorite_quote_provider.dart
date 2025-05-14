import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteQuoteProvider extends ChangeNotifier {
  final Box _favQuotesBox = Hive.box("favoritesBox");

  Box get favQuotesBox => _favQuotesBox;

  Future<void> addRemoveQuote(FavoriteQuoteModel quote) async {
    if (isFavorite(quote)) {
      await _favQuotesBox.delete("key_${quote.author}_${quote.quote}");
    } else {
      await _favQuotesBox.put("key_${quote.author}_${quote.quote}", quote);
    }
    notifyListeners();
  }

  bool isFavorite(FavoriteQuoteModel quote) {
    return _favQuotesBox.containsKey("key_${quote.author}_${quote.quote}");
  }
}
