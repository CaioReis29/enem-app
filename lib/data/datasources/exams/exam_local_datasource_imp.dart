import 'package:enem_app/data/datasources/exams/exam_local_datasource.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:objectbox/objectbox.dart';

class ExamLocalDatasourceImp extends ExamLocalDatasource{
  final Box<ExamEntity> examBox;

  ExamLocalDatasourceImp({required this.examBox});

  @override
  Future<void> saveExams(List<ExamEntity> exams) async {
    examBox.putMany(exams);
  }

  @override
  List<ExamEntity> getExams() {
    return examBox.getAll();
  }
}
