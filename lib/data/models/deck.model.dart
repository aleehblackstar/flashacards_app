import 'package:hive/hive.dart';
import 'card.model.dart';

// Essa linha também vai dar erro temporário
part 'deck.model.g.dart';

@HiveType(typeId: 0)
class DeckModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  List<CardModel> cards;

  DeckModel({required this.id, required this.name, required this.cards});
}
