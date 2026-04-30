import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/deck.model.dart';
// import '../card_add/card_add.page.dart'; // Usaremos em breve

class DeckDetailPage extends StatelessWidget {
  final int deckIndex;

  const DeckDetailPage({super.key, required this.deckIndex});

  @override
  Widget build(BuildContext context) {
    // Usamos o ValueListenableBuilder aqui também para que a tela
    // se atualize sozinha quando a quantidade de cartões mudar!
    return ValueListenableBuilder(
      valueListenable: Hive.box<DeckModel>('decksBox').listenable(),
      builder: (context, Box<DeckModel> box, _) {
        // Proteção caso o baralho seja excluído
        if (!box.containsKey(deckIndex) || box.getAt(deckIndex) == null) {
          return const Scaffold(
            body: Center(child: Text('Deck não encontrado')),
          );
        }

        final deck = box.getAt(deckIndex)!;

        return Scaffold(
          appBar: AppBar(
            // KEY OBRIGATÓRIA NO BACK BUTTON CONFORME PDF
            leading: BackButton(
              key: const Key("btnvoltar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(deck.name),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(height: 64),

                  // KEY OBRIGATÓRIA DO BOTÃO ADD CARTÃO
                  OutlinedButton(
                    key: const Key("addCard"),
                    onPressed: () {
                      // TODO: Navegar para tela de Adicionar Cartão
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

                  // KEY OBRIGATÓRIA DO BOTÃO INICIAR QUIZ
                  ElevatedButton(
                    key: const Key("startQuiz"),
                    onPressed: () {
                      // TODO: Navegar para tela de Quiz
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
