import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/data/datasources/exams/exam_datasource.dart';
import 'package:enem_app/data/datasources/exams/exam_local_datasource.dart';
import 'package:enem_app/data/datasources/network/network_info.dart';
import 'package:enem_app/data/models/exams/exam_model.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:enem_app/domain/repositories/exams/exam_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamDatasource datasource;
  final NetworkInfo networkInfo;
  final ExamLocalDatasource localDatasource;

  ExamRepositoryImpl({
    required this.datasource,
    required this.networkInfo,
    required this.localDatasource,
  });

  @override
  Future<Result<List<ExamEntity>, Failure>> getExams() async {
    if (await networkInfo.isConnected) {
      try {
        final List<ExamModel> exams = await datasource.getExams();
        await localDatasource.saveExams(exams);
        return Success(exams);
      } on Failure catch (failure) {
        return Error(failure);
      }
    } else {
      try {
        final exams = localDatasource.getExams();
        return Success(exams);
      } catch (e) {
        return Error(ApiFailure());
      }
    }
  }
}
