import '../../domain/entities/card_entity.dart';

class CardModel {
  final String title;
  final String subtitle;

  const CardModel({
    required this.title,
    required this.subtitle,
  });

  CardEntity toEntity() {
    return CardEntity(
      title: title,
      subtitle: subtitle,
    );
  }
}

const List<CardModel> cards = [
  CardModel(
    title: 'Save Your Meals Ingredient',
    subtitle: 'Add Your Meals and its Ingredients and we will save it for you',
  ),
  CardModel(
    title: 'Use Our App The Best Choice',
    subtitle: 'The best choice for your kitchen. Do not hesitate.',
  ),
  CardModel(
    title: 'Our App Your Ultimate Choice',
    subtitle: 'All the best restaurants and their top menus are ready for you',
  ),
];