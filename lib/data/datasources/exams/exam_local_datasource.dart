import 'package:enem_app/domain/entities/exams/exam_entity.dart';

abstract class ExamLocalDatasource {
  
  Future<void> saveExams(List<ExamEntity> exams);

  List<ExamEntity> getExams();

}