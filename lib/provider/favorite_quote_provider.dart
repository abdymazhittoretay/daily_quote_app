import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteQuoteProvider extends ChangeNotifier {
  late Box<FavoriteQuoteModel> _favQuotesBox;

  Future<void> initBox() async {
    _favQuotesBox = await Hive.openBox<FavoriteQuoteModel>("favQuotesBox");
  }

  Future<void> addQuote(FavoriteQuoteModel quote) async {
    await _favQuotesBox.put("key_${quote.author}_${quote.quote}", quote);
    notifyListeners();
  }

  Future<void> removeQuote(FavoriteQuoteModel quote) async {
    await _favQuotesBox.delete("key_${quote.author}_${quote.quote}");
    notifyListeners();
  }

  bool isFavorite(FavoriteQuoteModel quote) {
    return _favQuotesBox.containsKey("key_${quote.author}_${quote.quote}");
  }
}
