import 'package:enem_app/domain/entities/questions/alternatives_entity.dart';

class AlternativesModel extends AlternativesEntity {
  AlternativesModel({
    required super.letter,
    required super.text,
    required super.file,
    required super.isCorrect,
  });

  factory AlternativesModel.fromJson(Map<String, dynamic> json) {
    return AlternativesModel(
      letter: json["letter"],
      text: json["text"],
      file: json["file"],
      isCorrect: json["isCorrect"],
    );
  }

  Map<String, dynamic> toJson() => {
        "letter": letter,
        "text": text,
        "file": file,
        "isCorrect": isCorrect,
      };
}
