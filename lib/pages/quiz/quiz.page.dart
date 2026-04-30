import 'package:flutter/material.dart';
import '../../data/models/deck.model.dart';
import 'quiz_result.page.dart';

class QuizPage extends StatefulWidget {
  final DeckModel deck;

  const QuizPage({super.key, required this.deck});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  int _pontos = 0;
  bool _mostrarResposta = false;

  void _responder(bool acertou) {
    if (acertou) _pontos++;

    // Verifica se ainda tem mais cartões no baralho
    if (_currentIndex < widget.deck.cards.length - 1) {
      setState(() {
        _currentIndex++;
        _mostrarResposta = false; // Volta a mostrar a pergunta da próxima carta
      });
    } else {
      // Fim do quiz: Navega para a tela de resultado enviando os pontos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuizResultPage(deckName: widget.deck.name, pontos: _pontos),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.deck.cards[_currentIndex];
    final total = widget.deck.cards.length;

    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${widget.deck.name}')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Contador estilo "1/2" exigido no protótipo
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '${_currentIndex + 1}/$total',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(),

            // Exibe a Pergunta ou a Resposta, dependendo do estado
            Text(
              _mostrarResposta ? card.answer : card.question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Botão para virar a carta
            TextButton(
              onPressed: () {
                setState(() {
                  _mostrarResposta = !_mostrarResposta;
                });
              },
              child: Text(
                _mostrarResposta
                    ? 'Visualizar pergunta'
                    : 'Visualizar resposta',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            const Spacer(),

            // KEY OBRIGATÓRIA: ACERTOU
            ElevatedButton(
              key: const Key("btnAcertei"),
              onPressed: () => _responder(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Acertei :)',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),

            // KEY OBRIGATÓRIA: ERROU
            ElevatedButton(
              key: const Key("btnErrei"),
              onPressed: () => _responder(false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Errei :(',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
