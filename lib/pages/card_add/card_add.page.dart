import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/card.model.dart';
import '../../data/models/deck.model.dart';

class CardAddPage extends StatefulWidget {
  final int deckIndex;

  const CardAddPage({super.key, required this.deckIndex});

  @override
  State<CardAddPage> createState() => _CardAddPageState();
}

class _CardAddPageState extends State<CardAddPage> {
  final _perguntaController = TextEditingController();
  final _respostaController = TextEditingController();

  void _salvarCartao() {
    final pergunta = _perguntaController.text.trim();
    final resposta = _respostaController.text.trim();

    if (pergunta.isEmpty || resposta.isEmpty) return;

    final box = Hive.box<DeckModel>('decksBox');
    final deck = box.getAt(widget.deckIndex);

    // Se o baralho existir, adicionamos o cartão na lista dele
    if (deck != null) {
      final novoCartao = CardModel(question: pergunta, answer: resposta);
      deck.cards.add(novoCartao);

      // O comando .save() avisa o Hive que a lista interna mudou!
      deck.save();
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _perguntaController.dispose();
    _respostaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo cartão',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // KEY OBRIGATÓRIA DO INPUT DE PERGUNTA [cite: 132]
            TextField(
              key: const Key("inputPergunta"),
              controller: _perguntaController,
              decoration: const InputDecoration(
                labelText: 'Pergunta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // KEY OBRIGATÓRIA DO INPUT DE RESPOSTA [cite: 133]
            TextField(
              key: const Key("inputResposta"),
              controller: _respostaController,
              decoration: const InputDecoration(
                labelText: 'Resposta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 48),

            // KEY OBRIGATÓRIA DO BOTÃO ADICIONAR CARTÃO [cite: 134]
            ElevatedButton(
              key: const Key("addCardQuestion"),
              onPressed: _salvarCartao,
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
