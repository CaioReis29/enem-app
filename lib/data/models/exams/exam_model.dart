import 'package:enem_app/data/models/exams/discipline_model.dart';
import 'package:enem_app/data/models/exams/language_model.dart';
import 'package:enem_app/domain/entities/exams/discipline_entity.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:enem_app/domain/entities/exams/language_entity.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    super.id,
    required super.title,
    required super.year,
    List<DisciplineEntity>? disciplines,
    List<LanguageEntity>? languages,
  }) {
    this.disciplines.addAll(disciplines ?? []);
    this.languages.addAll(languages ?? []);
  }

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json["id"] ?? 0,
      title: json["title"],
      year: json["year"],
      disciplines: (json["disciplines"] as List<dynamic>?)
              ?.map((j) => DisciplineModel.fromJson(j as Map<String, dynamic>))
              .toList() ??
          [],
      languages: (json["languages"] as List<dynamic>?)
              ?.map((j) => LanguageModel.fromJson(j as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
        "disciplines": disciplines.map((d) => (d as DisciplineModel).toJson()).toList(),
        "languages": languages.map((l) => (l as LanguageModel).toJson()).toList(),
      };
}
