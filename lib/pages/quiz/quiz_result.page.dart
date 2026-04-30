import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  final String deckName;
  final int pontos;

  const QuizResultPage({
    super.key,
    required this.deckName,
    required this.pontos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: $deckName'),
        // Oculta a seta nativa de voltar do topo para forçar o uso do botão inferior
        leading: const SizedBox.shrink(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto formatado com as quebras de linha exatas do protótipo
            Text(
              'O quiz acabou.\nVocê fez $pontos\nponto(s)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),

            // KEY OBRIGATÓRIA: VOLTAR DA TELA DE RESULTADO
            TextButton(
              key: const Key("btnVoltar"),
              onPressed: () {
                // Como essa tela substituiu a do Quiz, precisamos voltar
                // para a tela de Detalhes do Baralho.
                Navigator.pop(context);
              },
              child: const Text(
                'Voltar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
