import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class QuestionsRepository {
  Future<Result<QuestionsEntity, Failure>>getQuestions(GetQuestionsParams params);
}