import 'package:enem_app/domain/entities/exams/discipline_entity.dart';
import 'package:enem_app/domain/entities/exams/language_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ExamEntity {

  @Id()
  int id;

  final String title;
  final int year;

  @Backlink()
  final disciplines = ToMany<DisciplineEntity>();

  @Backlink()
  final languages = ToMany<LanguageEntity>();


  ExamEntity({
    this.id = 0,
    required this.title,
    required this.year,
  });

}
