import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/deck.model.dart';

class DeckAddPage extends StatefulWidget {
  const DeckAddPage({super.key});

  @override
  State<DeckAddPage> createState() => _DeckAddPageState();
}

class _DeckAddPageState extends State<DeckAddPage> {
  final _titleController = TextEditingController();

  void _salvarDeck() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    // Criando o objeto do baralho com ID único e lista de cartões vazia
    final novoDeck = DeckModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: title,
      cards: [],
    );

    // Salvando no Hive e voltando para a tela anterior
    Hive.box<DeckModel>('decksBox').add(novoDeck);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo deck',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Qual é o título\ndo seu novo\ndeck?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),

            // KEY OBRIGATÓRIA DO INPUT
            TextField(
              key: const Key("tituloDeck"),
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título do deck',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // KEY OBRIGATÓRIA DO BOTÃO
            ElevatedButton(
              key: const Key("btnAdicionarDeck"),
              onPressed: _salvarDeck,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Adicionar', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
