import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:enem_app/domain/usecases/exams/get_exams.dart';
import 'package:enem_app/presentation/controllers/exams/exam_state.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

class ExamsController extends ValueNotifier<ExamState> {
  final GetExams getExams;

  ExamsController({required this.getExams}) : super(InitialExamState());

  Future<void> fetchExams() async {
    value = LoadingExamState();
    final result = await getExams.call(NoParameter());
    switch (result) {
      case Success():
        value = SuccessExamState(exams: result.success);
      case Error():
        value = FailureExamState(result.error.msg);
    }
  }
}
