
import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ExamRepository {
  Future<Result<List<ExamEntity>, Failure>>getExams();
}