import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/card_entity.dart';

abstract class OnboardingRepository {
  List<CardEntity> getCards();
}
