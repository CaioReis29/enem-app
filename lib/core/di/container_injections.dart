import 'package:dio/dio.dart';
import 'package:enem_app/data/datasources/exams/exam_datasource.dart';
import 'package:enem_app/data/datasources/exams/exam_datasource_impl.dart';
import 'package:enem_app/data/datasources/network/network_info.dart';
import 'package:enem_app/data/datasources/questions/question_datasource.dart';
import 'package:enem_app/data/datasources/questions/question_datasource_impl.dart';
import 'package:enem_app/data/repositories/exams/exam_repository_impl.dart';
import 'package:enem_app/data/repositories/questions/questions_repository_impl.dart';
import 'package:enem_app/domain/repositories/exams/exam_repository.dart';
import 'package:enem_app/domain/repositories/questions/questions_repository.dart';
import 'package:enem_app/domain/usecases/exams/get_exams.dart';
import 'package:enem_app/domain/usecases/exams/get_questions.dart';
import 'package:enem_app/presentation/controllers/exams/exams_controller.dart';
import 'package:enem_app/presentation/controllers/questions/questions_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpContainer() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetChecker: getIt<InternetConnectionChecker>()));

  exams();
  questions();
}

void exams() {
  getIt.registerLazySingleton<ExamDatasource>(() => ExamDatasourceImpl(dio: getIt<Dio>()));

  getIt.registerLazySingleton<ExamRepository>(() => ExamRepositoryImpl(datasource: getIt<ExamDatasource>(), networkInfo: getIt<NetworkInfo>()));

  getIt.registerLazySingleton<GetExams>(() => GetExams(repository: getIt<ExamRepository>()));

  getIt.registerFactory(() => ExamsController(getExams: getIt<GetExams>()));
}

void questions() {
  getIt.registerLazySingleton<QuestionDatasource>(() => QuestionDatasourceImpl(dio: getIt<Dio>()));

  getIt.registerLazySingleton<QuestionsRepository>(() => QuestionsRepositoryImpl(datasource: getIt<QuestionDatasource>(), networkInfo: getIt<NetworkInfo>()));

  getIt.registerLazySingleton<GetQuestions>(() => GetQuestions(repository: getIt<QuestionsRepository>()));

  getIt.registerFactory(() => QuestionsController(getQuestions: getIt<GetQuestions>()));
}