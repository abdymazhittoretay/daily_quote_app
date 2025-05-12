import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteQuoteProvider extends ChangeNotifier {
  late Box<FavoriteQuoteModel> _favQuotesBox;
}
