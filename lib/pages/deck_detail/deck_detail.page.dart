import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/deck.model.dart';
import '../card_add/card_add.page.dart';
import '../quiz/quiz.page.dart';

class DeckDetailPage extends StatelessWidget {
  final int deckIndex;

  const DeckDetailPage({super.key, required this.deckIndex});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<DeckModel>('decksBox').listenable(),
      builder: (context, Box<DeckModel> box, _) {
        if (!box.containsKey(deckIndex) || box.getAt(deckIndex) == null) {
          return const Scaffold(
            body: Center(child: Text('Deck não encontrado')),
          );
        }

        final deck = box.getAt(deckIndex)!;

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              key: const Key("btnvoltar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(deck.name),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  deck.name,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${deck.cards.length} cartões',
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 32),

                OutlinedButton(
                  key: const Key("addCard"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardAddPage(deckIndex: deckIndex),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Cartão',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  key: const Key("startQuiz"),
                  onPressed: deck.cards.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(deck: deck),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Quiz',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 32),
                const Divider(),

                // --- AQUI COMEÇA A NOVIDADE: A LISTA DE CARTÕES ---
                Expanded(
                  child: deck.cards.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum cartão adicionado ainda.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: deck.cards.length,
                          itemBuilder: (context, index) {
                            final card = deck.cards[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                card.question,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(card.answer),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // Remove o cartão da lista interna
                                  deck.cards.removeAt(index);
                                  // Salva a alteração no Hive (Isso atualiza a tela na hora!)
                                  deck.save();
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
