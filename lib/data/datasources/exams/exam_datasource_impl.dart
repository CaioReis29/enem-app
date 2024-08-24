
import 'package:dio/dio.dart';
import 'package:enem_app/core/api_urls.dart';
import 'package:enem_app/core/exceptions/failure.dart';
import 'package:enem_app/data/datasources/exams/exam_datasource.dart';
import 'package:enem_app/data/models/exams/exam_model.dart';

class ExamDatasourceImpl extends ExamDatasource {
  final Dio dio;
  ExamDatasourceImpl({required this.dio});

  @override
  Future<List<ExamModel>> getExams() async{
    Response response;

    try {
      response = await dio.get(ApiUrls.path + ApiUrls.exams);
    } catch (failure) {
      throw ApiFailure();
    }

    if(response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      List<ExamModel> exams = jsonList.map((json) => ExamModel.fromJson(json)).toList(); 
      return exams;
    } else {
      throw ApiFailure();
    }
  }
  
}