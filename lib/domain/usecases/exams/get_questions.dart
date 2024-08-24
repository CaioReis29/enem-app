import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/domain/repositories/questions/questions_repository.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:multiple_result/multiple_result.dart';

class GetQuestions extends Usecase<QuestionsEntity, GetQuestionsParams> {
  final QuestionsRepository repository;

  GetQuestions({required this.repository});

  @override
  Future<Result<QuestionsEntity, Failure>> call(parameter) async {
    return await repository.getQuestions(parameter);
  }
}