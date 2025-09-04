import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/card_entity.dart';
import '../repo_interface/onboarding_repository.dart';

class GetCardsUseCase {
  final OnboardingRepository onboardingRepository;

  GetCardsUseCase(this.onboardingRepository);

  List<CardEntity> call() => onboardingRepository.getCards();
}