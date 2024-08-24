
import 'package:enem_app/domain/entities/exams/language_entity.dart';

class LanguageModel extends LanguageEntity {
  LanguageModel({required super.label, required super.value});
  
  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      label: json["label"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}