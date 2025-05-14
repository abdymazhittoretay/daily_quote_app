import 'package:hive/hive.dart';

part 'favorite_quote_model.g.dart';

@HiveType(typeId: 1)
class FavoriteQuoteModel {
  @HiveField(0)
  final String quote;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final DateTime dateTime;

  FavoriteQuoteModel({
    required this.quote,
    required this.author,
    required this.dateTime,
  });
}
