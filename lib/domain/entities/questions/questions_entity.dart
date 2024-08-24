
import 'package:enem_app/domain/entities/questions/metadata_entity.dart';
import 'package:enem_app/domain/entities/questions/question_entity.dart';

class QuestionsEntity {
 final MetadataEntity metaData;
 final List<QuestionEntity> questions;

 QuestionsEntity({required this.metaData, required this.questions}); 
}