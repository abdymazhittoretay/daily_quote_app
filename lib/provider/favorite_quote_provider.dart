import 'package:daily_quote_app/boxes.dart';
import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteQuoteProvider extends ChangeNotifier {
  Future<void> addRemoveQuote(FavoriteQuoteModel quote) async {
    if (isFavorite(quote)) {
      await favQuotesBox.delete("key_${quote.author}_${quote.quote}");
    } else {
      await favQuotesBox.put("key_${quote.author}_${quote.quote}", quote);
    }
    notifyListeners();
  }

  bool isFavorite(FavoriteQuoteModel quote) {
    return favQuotesBox.containsKey("key_${quote.author}_${quote.quote}");
  }
}
