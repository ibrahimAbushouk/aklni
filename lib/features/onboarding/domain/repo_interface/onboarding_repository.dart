import '../entities/card_entity.dart';

abstract class OnboardingRepository {
  List<CardEntity> getCards();
}
