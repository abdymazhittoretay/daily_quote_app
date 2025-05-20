import 'package:daily_quote_app/models/favorite_quote_model.dart';
import 'package:daily_quote_app/pages/home_page.dart';
import 'package:daily_quote_app/provider/favorite_quote_provider.dart';
import 'package:daily_quote_app/provider/quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteQuoteModelAdapter());
  await Hive.openBox("favoritesBox");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteQuoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
