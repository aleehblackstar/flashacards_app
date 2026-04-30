import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/deck.model.dart';
import '../deck_add/deck_add.page.dart';
import '../deck_detail/deck_detail.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Função auxiliar para navegar para a tela de adicionar
  void _irParaAdicionarDeck(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeckAddPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Decks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<DeckModel>('decksBox').listenable(),
        builder: (context, Box<DeckModel> box, _) {
          // ESTADO VAZIO (A tela do barquinho)
          if (box.values.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/no_decks.png',
                    key: const Key("image"),
                    width: 300,
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OutlinedButton(
                      key: const Key("btnOutlineAdicionar"),
                      onPressed: () => _irParaAdicionarDeck(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Adicionar deck',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // ESTADO PREENCHIDO: Lista de Baralhos
          final decks = box.values.toList().cast<DeckModel>();

          return ListView.separated(
            itemCount: decks.length,
            separatorBuilder: (_, _) =>
                const Divider(height: 1, color: Colors.black12),
            itemBuilder: (context, index) {
              final deck = decks[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeckDetailPage(deckIndex: index),
                    ),
                  );
                },
                // REQUISITO: Excluir baralho ao manter pressionado
                onLongPress: () => box.deleteAt(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Text(deck.name, style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 8),
                      Text(
                        '${deck.cards.length} cartões',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key("btnAdicionar"),
        onPressed: () => _irParaAdicionarDeck(context),
        label: const Text(
          'Adicionar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
