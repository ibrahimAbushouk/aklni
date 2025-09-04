import '../../domain/entities/card_entity.dart';
import '../model/card_model.dart';

extension CardModelMapper on CardModel {
  CardEntity toEntity() => CardEntity(
    title: title,
    subtitle: subtitle,
  );
}