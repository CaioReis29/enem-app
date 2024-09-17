import 'package:enem_app/domain/entities/questions/metadata_entity.dart';
import 'package:enem_app/domain/entities/questions/question_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class QuestionsEntity {
  @Id()
  int id;
  final metaData = ToOne<MetadataEntity>();

  @Backlink('questions')
  final questions = ToMany<QuestionEntity>();

  QuestionsEntity({
    this.id = 0,
  });
}
