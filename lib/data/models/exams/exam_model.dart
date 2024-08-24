import 'package:enem_app/data/models/exams/discipline_model.dart';
import 'package:enem_app/data/models/exams/language_model.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';

class ExamModel extends ExamEntity {
  const ExamModel({
    required super.title,
    required super.year,
    required super.disciplines,
    required super.languages,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      title: json["title"],
      year: json["year"],
      disciplines: (json["disciplines"] as List<dynamic>?)?.map((j) => DisciplineModel.fromJson(j as Map<String, dynamic>)).toList() ?? [],
      languages: (json["languages"] as List<dynamic>?)?.map((j) => LanguageModel.fromJson(j as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "year": year,
    "disciplines": disciplines,
    "languages": languages,
  };
}
