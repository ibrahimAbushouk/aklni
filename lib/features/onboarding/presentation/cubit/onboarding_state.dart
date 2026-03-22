import '../../domain/entities/card_entity.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final List<CardEntity> cards;

  OnboardingLoaded(this.cards);
}

class OnboardingError extends OnboardingState {
  final String message;

  OnboardingError(this.message);
}