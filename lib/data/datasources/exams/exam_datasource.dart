import 'package:enem_app/data/models/exams/exam_model.dart';

abstract class ExamDatasource {
  Future<List<ExamModel>>getExams();
}