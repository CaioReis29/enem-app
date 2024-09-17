import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/data/datasources/network/network_info.dart';
import 'package:enem_app/data/datasources/questions/question_datasource.dart';
import 'package:enem_app/data/datasources/questions/question_local_datasource.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/domain/repositories/questions/questions_repository.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:multiple_result/multiple_result.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionDatasource datasource;
  final NetworkInfo networkInfo;
  final QuestionLocalDatasource localDatasource;

  QuestionsRepositoryImpl({
    required this.datasource,
    required this.networkInfo,
    required this.localDatasource,
  });

  @override
  Future<Result<QuestionsEntity, Failure>> getQuestions(GetQuestionsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final QuestionsEntity questions = await datasource.getQuestions(params);
        await localDatasource.saveQuestions(questions);
        return Success(questions);
      } on Failure catch (failure) {
        return Error(failure);
      }
    } else {
      try {
        final questions = await localDatasource.getQuestions(int.parse(params.year), params.language);
        return Success(questions!);
      } on Failure catch (_) {
        return Error(LocalDBNotFound());
      }
    }
  }
}
