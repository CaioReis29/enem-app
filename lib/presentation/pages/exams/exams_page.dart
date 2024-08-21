import 'package:enem_app/core/container_injections.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/single_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/domain/entities/exam_entity.dart';
import 'package:enem_app/presentation/components/app_primary_button.dart';
import 'package:enem_app/presentation/controllers/exams/exam_state.dart';
import 'package:enem_app/presentation/controllers/exams/exams_controller.dart';
import 'package:flutter/material.dart';

class ExamsPage extends StatefulWidget {

  const ExamsPage({ super.key });

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> with SingleNotifierMixin {
  final _controller = getIt<ExamsController>();

  @override
  void initState() {
    notifierAction(_controller);
    _controller.fetchExams();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Exames')),
           body: SafeArea(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: switch (_controller.value) {
                 SuccessExamState(:List<ExamEntity> exams) => ListView.builder(
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];
                    return Card(
                      color: AppColor.grey,
                      elevation: 6,
                      child: SizedBox(
                        width: context.getWidth(),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exam.title,
                                style: AppTextStyle.poppinsW600s18,
                              ),
                              const SizedBox(height: 12),
                              Text("Disciplinas:", style: AppTextStyle.poppinsW600s18),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: exam.disciplines.map((d) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text("- ${d.label}", style: AppTextStyle.poppinsW300s14),
                                );
                              }).toList(),
                              ),
                              const SizedBox(height: 12), 
                              Text("Linguagens:", style: AppTextStyle.poppinsW600s18),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: exam.languages.map((l) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text("- ${l.label}", style: AppTextStyle.poppinsW300s14),
                                );
                              }).toList(),
                              ),
                              const SizedBox(height: 12),
                              AppPrimaryButton(
                                text: "Praticar questões",
                                onPressed: (){},
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                 LoadingExamState() => CircularProgressIndicator
                  .adaptive(
                    backgroundColor: AppColor.primary,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ).centralized(),
                 FailureExamState(:String msg) => Text(msg).centralized(),
                 _ => const Text("Erro desconhecido").centralized(),
               },
             ),
           )
       );
  }
}