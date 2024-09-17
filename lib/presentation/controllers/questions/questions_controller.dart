import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/domain/usecases/core/usecase.dart';
import 'package:enem_app/domain/usecases/exams/get_questions.dart';
import 'package:enem_app/presentation/controllers/questions/questions_state.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

class QuestionsController extends ValueNotifier<QuestionsState> {
  final GetQuestions getQuestions;

  QuestionsController({required this.getQuestions})
      : super(InitialQuestionsState());

  final int _limit = 20;
  int _offset = 0;
  bool hasMore = true;
  late QuestionsEntity questionEntity;

  Future<void> fetchQuestions(String year, {String? language}) async {
    if(!hasMore) return;

    value = LoadingQuestionsState();
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
        value = SuccessQuestionsState(questions: questionEntity);
        if(result.success.metaData.target != null) hasMore = questionEntity.metaData.target!.hasMore;
      case Error():
        value = FailureQuestionsState(result.error.msg);
    }
  }

  Future<void> pagination(String year, {String? language}) async {
    value = LoadingPaginationState();
    if(!hasMore) return;
    _offset += 20;

    final params = GetQuestionsParams(
      year: year,
      limit: _limit,
      offset: _offset,
      language: language,
    );
    final result = await getQuestions.call(params);
    switch (result) {
      case Success():
        questionEntity.questions.addAll(result.success.questions);
        value = SuccessPaginationState(questions: questionEntity);
        if(result.success.metaData.target != null) hasMore = result.success.metaData.target!.hasMore;
      case Error():
        value = FailureQuestionsState(result.error.msg);
    }
  }
}
