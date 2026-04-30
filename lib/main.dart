import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/card.model.dart';
import 'data/models/deck.model.dart';
import 'pages/home/home.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrando os adaptadores que o build_runner acabou de criar
  Hive.registerAdapter(CardModelAdapter());
  Hive.registerAdapter(DeckModelAdapter());

  // Abrindo a "caixa" (tabela) onde os baralhos serão salvos
  await Hive.openBox<DeckModel>('decksBox');

  runApp(const FlashCardsApp());
}

class FlashCardsApp extends StatelessWidget {
  const FlashCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashCards Growdev',
      debugShowCheckedModeBanner: false,
      // Aplicando o tema padrão do protótipo (Preto e Branco)
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: StadiumBorder(),
        ),
      ),
      home: const HomePage(),
    );
  }
}
