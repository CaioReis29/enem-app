import 'dart:convert';

import 'package:enem_app/data/models/questions/alternatives_model.dart';
import 'package:enem_app/domain/entities/questions/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.title,
    required super.index,
    required super.discipline,
    required super.language,
    required super.year,
    required super.context,
    required super.files,
    required super.correctAlternative,
    super.alternativesIntroduction,
    required super.alternatives,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      title: json["title"],
      index: json["index"],
      discipline: json["discipline"],
      language: json["language"],
      year: json["year"],
      context: json["context"],
      files: (json["files"] as List<dynamic>).map((j) {
        return jsonEncode(j);
      }).toList(),
      correctAlternative: CorrectAlternative.values.firstWhere(
        (e) => e.toString().split('.').last == json["correctAlternative"],),
      alternativesIntroduction: json["alternativesIntroduction"],
      alternatives: (json["alternatives"] as List<dynamic>?)
              ?.map((j) => AlternativesModel.fromJson(j as Map<String, dynamic>))
              .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "index": index,
        "discipline": discipline,
        "language": language,
        "year": year,
        "context": context,
        "files": files,
        "correctAlternative": correctAlternative,
        "alternativesIntroduction": alternativesIntroduction,
      };
}