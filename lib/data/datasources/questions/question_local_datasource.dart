
import 'package:enem_app/domain/entities/questions/questions_entity.dart';

abstract class QuestionLocalDatasource { 
  Future<void> saveQuestions(QuestionsEntity questions);

  Future<QuestionsEntity?> getQuestions(int year, String? language);
}