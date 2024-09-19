import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:enem_app/domain/usecases/exams/get_exams.dart';
import 'package:enem_app/presentation/controllers/to_pratice/to_pratice_state.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

class ToPraticeController extends ValueNotifier<ToPraticeState> {
  final GetExams getExams;

  ToPraticeController({required this.getExams}) : super(InitialToPraticeState());

  Future<void> fetchExams() async {
    value = LoadingToPraticeState();
    final result = await getExams.call(NoParameter());
    switch (result) {
      case Success():
        value = SuccessToPraticeState(exams: result.success);
      case Error():
        value = FailureToPraticeState(result.error.msg);
    }
  }
}