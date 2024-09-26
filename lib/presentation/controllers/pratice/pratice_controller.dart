import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:enem_app/domain/usecases/exams/get_questions.dart';
import 'package:enem_app/presentation/controllers/pratice/pratice_state.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
class PraticeController extends ValueNotifier<PraticeState> {
  final GetQuestions getQuestions;
  PraticeController({required this.getQuestions})
      : super(InitialPraticeState());
  final int _limit = 1;
  int _offset = 1;
  bool hasMore = true;
  late QuestionsEntity questionEntity;

  Future<void> loadQuestion(String year, {String? language}) async {
    if(!hasMore) return;
    _offset = 1;
    value = LoadingPraticeState();
    final params = GetQuestionsParams(
      year: year,
      limit: _limit,
      offset: _offset,
      language: language,
    );
    final result = await getQuestions.call(params);
    switch (result) {
      case Success():
        questionEntity = result.success;
        value = LoadedQuestionState(questions: questionEntity);
        if(result.success.metaData.target != null) hasMore = questionEntity.metaData.target!.hasMore;
      case Error():
        value = FailurePraticeState(result.error.msg);
    }
  }

  Future<void> loadNextQuestion(String year, {String? language}) async {
    if(!hasMore) return;
    _offset++;
    value = LoadingPraticeState();
    final params = GetQuestionsParams(
      year: year,
      limit: _limit,
      offset: _offset,
      language: language,
    );
    final result = await getQuestions.call(params);
    switch (result) {
      case Success():
        questionEntity = result.success;
        value = LoadedQuestionState(questions: questionEntity);
        if(result.success.metaData.target != null) hasMore = questionEntity.metaData.target!.hasMore;
      case Error():
        value = FailurePraticeState(result.error.msg);
    }
  }
}