import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LanguageEntity {
  @Id()
  int id;

  final String label;
  final String value;

  final exam = ToOne<ExamEntity>();

  LanguageEntity({
    this.id = 0,
    required this.label,
    required this.value,
  });
}
