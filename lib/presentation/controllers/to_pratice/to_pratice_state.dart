import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ToPraticeState extends Equatable{
  const ToPraticeState();

  @override
  List<Object?> get props => [];
}

class InitialToPraticeState extends ToPraticeState {}

class LoadingToPraticeState extends ToPraticeState {}

class SuccessToPraticeState extends ToPraticeState {
  final List<ExamEntity> exams;

  const SuccessToPraticeState({required this.exams});

  @override
  List<Object?> get props => [exams];
}

class FailureToPraticeState extends ToPraticeState {
  final String msg;

  const FailureToPraticeState(this.msg);

  @override
  List<Object?> get props => [msg];
}

class OfflineToPraticeState extends ToPraticeState {}