import 'package:enem_app/data/models/questions/metadata_model.dart';
import 'package:enem_app/data/models/questions/question_model.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';

class QuestionsModel extends QuestionsEntity {
  QuestionsModel({
    MetadataModel? metaData,
    List<QuestionModel>? questions,
  }) {
    this.metaData;
    this.questions.addAll(questions ?? []);
  }

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      metaData:
          MetadataModel.fromJson(json["metadata"] as Map<String, dynamic>),
      questions: (json["questions"] as List<dynamic>?)
              ?.map((j) => QuestionModel.fromJson(j as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "metadata": metaData,
        "questions": questions,
      };
}
