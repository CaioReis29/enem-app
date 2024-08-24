import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ExamState extends Equatable{
  const ExamState();

  @override
  List<Object?> get props => [];
}

class InitialExamState extends ExamState {}

class LoadingExamState extends ExamState {}

class SuccessExamState extends ExamState {
  final List<ExamEntity> exams;

  const SuccessExamState({required this.exams});

  @override
  List<Object?> get props => [exams];
}

class FailureExamState extends ExamState {
  final String msg;

  const FailureExamState(this.msg);

  @override
  List<Object?> get props => [msg];
}

class OfflineExamState extends ExamState {}