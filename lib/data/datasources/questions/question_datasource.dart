import 'package:enem_app/data/models/questions/questions_model.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';

abstract class QuestionDatasource {
  Future<QuestionsModel> getQuestions(GetQuestionsParams params);
}