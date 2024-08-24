import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:enem_app/domain/repositories/exams/exam_repository.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:multiple_result/multiple_result.dart';

class GetExams extends Usecase<List<ExamEntity>, NoParameter> {
  final ExamRepository repository;

  GetExams({required this.repository});

  @override
  Future<Result<List<ExamEntity>, Failure>> call(NoParameter parameter) async {
    return await repository.getExams();
  }
}