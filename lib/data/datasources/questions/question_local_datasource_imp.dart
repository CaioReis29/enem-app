
import 'package:enem_app/data/datasources/questions/question_local_datasource.dart';
import 'package:enem_app/domain/entities/questions/question_entity.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/objectbox.g.dart';

class QuestionLocalDatasourceImp extends QuestionLocalDatasource {
  final Box<QuestionsEntity> questionsBox;
  final Box<QuestionEntity> questionBox;
  
  QuestionLocalDatasourceImp({required this.questionsBox, required this.questionBox});

  @override
  Future<QuestionsEntity?> getQuestions(int year, String? language) async {
    final query = questionBox
    .query(
      QuestionEntity_.year.equals(year)
      .and(QuestionEntity_.language.equals(language!)
    )).build();

    final List<QuestionEntity> matchingQuestions = query.find();
    query.close();

    final Set<QuestionsEntity> questionsEntities = {};
    for (var question in matchingQuestions) {
      final relatedQuestionsEntity = question.questions.target;
      if (relatedQuestionsEntity != null) {
        questionsEntities.add(relatedQuestionsEntity);
      }
    }

    return questionsEntities.isNotEmpty ? questionsEntities.first : null;
  }

  @override
  Future<void> saveQuestions(QuestionsEntity questions) async{
    questionsBox.put(questions);
  }
  
}