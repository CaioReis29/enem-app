import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:objectbox/objectbox.dart';

class ExamLocalDatasource {
  final Box<ExamEntity> examBox;

  ExamLocalDatasource({required this.examBox});

  Future<void> saveExams(List<ExamEntity> exams) async {
    examBox.putMany(exams);
  }

  List<ExamEntity> getExams() {
    return examBox.getAll();
  }
}
