import 'package:enem_app/domain/entities/questions/alternatives_entity.dart';

class QuestionEntity {
  final String title;
  final int index;
  final String? discipline;
  final String? language;
  final int year;
  final String? context;
  final List<String> files;
  final CorrectAlternative correctAlternative;
  final String? alternativesIntroduction;
  final List<AlternativesEntity> alternatives;

  QuestionEntity({
    required this.title,
    required this.index,
    required this.discipline,
    required this.language,
    required this.year,
    required this.context,
    required this.files,
    required this.correctAlternative,
    this.alternativesIntroduction,
    required this.alternatives,
  });
}

enum CorrectAlternative {
  A,
  B,
  C,
  D,
  E,
}
