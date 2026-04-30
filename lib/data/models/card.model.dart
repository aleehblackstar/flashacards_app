import 'package:hive/hive.dart';

// Essa linha vai dar erro no VS Code até rodarmos o gerador, é normal!
part 'card.model.g.dart';

@HiveType(typeId: 1)
class CardModel {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final String answer;

  CardModel({required this.question, required this.answer});
}
