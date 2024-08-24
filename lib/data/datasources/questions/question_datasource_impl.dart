
import 'package:dio/dio.dart';
import 'package:enem_app/core/api_urls.dart';
import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/data/datasources/questions/question_datasource.dart';
import 'package:enem_app/data/models/questions/questions_model.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';

class QuestionDatasourceImpl implements QuestionDatasource {
  final Dio dio;

  QuestionDatasourceImpl({required this.dio});

  @override
  Future<QuestionsModel> getQuestions(GetQuestionsParams params) async{
    Response response;

    try {
      response = await dio.get(
        "${ApiUrls.path}${ApiUrls.exams}/${params.year}${ApiUrls.questions}",
        queryParameters: {
          if(params.limit != null) 'limit': params.limit,
          if(params.offset != null) 'offset': params.offset,
          if(params.language != null) 'language': params.language,
        }
      );
    } catch (failure) {
      throw ApiFailure();
    }

    if(response.statusCode == 200) {
      dynamic json = response.data;
      QuestionsModel questions = QuestionsModel.fromJson(json); 
      return questions;
    } else {
      throw ApiFailure();
    }
  }
  
}