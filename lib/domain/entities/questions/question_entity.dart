import 'package:enem_app/domain/entities/questions/alternatives_entity.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class QuestionEntity {
  @Id()
  int id;

  final String title;
  final int index;
  final String? discipline;
  final String? language;
  final int year;
  final String? context;
  final List<String> files;
  final String correctAlternative;
  final String? alternativesIntroduction;
  final alternatives = ToMany<AlternativesEntity>();

  final questions = ToOne<QuestionsEntity>();

  QuestionEntity({
    this.id = 0,
    required this.title,
    required this.index,
    required this.discipline,
    required this.language,
    required this.year,
    required this.context,
    required this.files,
    required this.correctAlternative,
    this.alternativesIntroduction,
  });
}
