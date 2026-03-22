import '../model/card_model.dart';

abstract class OnboardingLocalDataSource {
  List<CardModel> getCards();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  List<CardModel> getCards() => cards;
}