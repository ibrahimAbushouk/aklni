import '../../domain/entities/card_entity.dart';
import '../../domain/repo_interface/onboarding_repository.dart';
import '../remote_data_sources/onboarding_local_dataSource.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  List<CardEntity> getCards() {
    return localDataSource.getCards().map((e) => e.toEntity()).toList();
  }
}