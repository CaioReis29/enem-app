import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/data/datasources/exams/exam_datasource.dart';
import 'package:enem_app/data/datasources/exams/exam_datasource_impl.dart';
import 'package:enem_app/data/datasources/exams/exam_local_datasource.dart';
import 'package:enem_app/data/datasources/exams/exam_local_datasource_imp.dart';
import 'package:enem_app/data/datasources/network/network_info.dart';
import 'package:enem_app/data/datasources/questions/question_datasource.dart';
import 'package:enem_app/data/datasources/questions/question_datasource_impl.dart';
import 'package:enem_app/data/datasources/questions/question_local_datasource.dart';
import 'package:enem_app/data/datasources/questions/question_local_datasource_imp.dart';
import 'package:enem_app/data/repositories/exams/exam_repository_impl.dart';
import 'package:enem_app/data/repositories/questions/questions_repository_impl.dart';
import 'package:enem_app/data/shared/shared_preference_service.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:enem_app/domain/entities/questions/question_entity.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/domain/repositories/exams/exam_repository.dart';
import 'package:enem_app/domain/repositories/questions/questions_repository.dart';
import 'package:enem_app/domain/usecases/exams/get_exams.dart';
import 'package:enem_app/domain/usecases/exams/get_questions.dart';
import 'package:enem_app/objectbox.g.dart';
import 'package:enem_app/presentation/controllers/exams/exams_controller.dart';
import 'package:enem_app/presentation/controllers/questions/questions_controller.dart';
import 'package:enem_app/presentation/controllers/to_pratice/to_pratice_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpContainer() async {
  final SharedPreferences shared = await SharedPreferences.getInstance();

  var dir = await getApplicationDocumentsDirectory();

  Store store = await openStore(directory: dir.path);

  getIt.registerLazySingleton(() => store.box<ExamEntity>());

  getIt.registerLazySingleton(() => store.box<QuestionsEntity>());

  getIt.registerLazySingleton(() => store.box<QuestionEntity>());

  getIt.registerLazySingleton<SharedPreferenceService>(() => SharedPreferenceService(shared));

  getIt.registerSingleton<AppTheme>(AppTheme());
  
  getIt.registerLazySingleton<Dio>(() {
    var options = BaseOptions();

    final dio = Dio(options);

    dio.interceptors.addAll([
      LogInterceptor(
        logPrint: (object) {
          log(object.toString(), name: "DIO LOG'S");
        },
    ),
  ]);

    return dio;
  });

  getIt.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker(),);

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetChecker: getIt<InternetConnectionChecker>()));

  exams();
  questions();
  toPratice();
}

void exams() {
  getIt.registerLazySingleton<ExamLocalDatasource>(() => ExamLocalDatasourceImp(examBox: getIt()));

  getIt.registerLazySingleton<ExamDatasource>(() => ExamDatasourceImpl(dio: getIt<Dio>()));

  getIt.registerLazySingleton<ExamRepository>(() => ExamRepositoryImpl(
    datasource: getIt<ExamDatasource>(), 
    networkInfo: getIt<NetworkInfo>(), 
    localDatasource: getIt<ExamLocalDatasource>(),
  ));

  getIt.registerLazySingleton<GetExams>(() => GetExams(repository: getIt<ExamRepository>()));

  getIt.registerFactory(() => ExamsController(getExams: getIt<GetExams>()));
}

void questions() {
  getIt.registerLazySingleton<QuestionLocalDatasource>(() => QuestionLocalDatasourceImp(
    questionsBox: getIt(), 
    questionBox: getIt(),
  ));

  getIt.registerLazySingleton<QuestionDatasource>(() => QuestionDatasourceImpl(dio: getIt<Dio>()));

  getIt.registerLazySingleton<QuestionsRepository>(() => QuestionsRepositoryImpl(
    datasource: getIt<QuestionDatasource>(), 
    networkInfo: getIt<NetworkInfo>(),
    localDatasource: getIt<QuestionLocalDatasource>(),
  ));

  getIt.registerLazySingleton<GetQuestions>(() => GetQuestions(repository: getIt<QuestionsRepository>()));

  getIt.registerFactory<QuestionsController>(() => QuestionsController(getQuestions: getIt<GetQuestions>()));
}

void toPratice() {
  getIt.registerLazySingleton(() => ToPraticeController(getExams: getIt<GetExams>()));
}