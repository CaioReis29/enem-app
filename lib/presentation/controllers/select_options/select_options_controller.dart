import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:enem_app/domain/usecases/exams/get_exams.dart';
import 'package:enem_app/presentation/controllers/select_options/select_options_state.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

class SelectOptionsController extends ValueNotifier<SelectOptionsState> {
  final GetExams getExams;

  SelectOptionsController({required this.getExams}) : super(InitialSelectOptionsState());

  Future<void> fetchExams() async {
    value = LoadingSelectOptionsState();
    final result = await getExams.call(NoParameter());
    switch (result) {
      case Success():
        value = SuccessSelectOptionsState(exams: result.success);
      case Error():
        value = FailureSelectOptionsState(result.error.msg);
    }
  }
  
}