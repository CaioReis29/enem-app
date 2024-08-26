import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/multiple_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:enem_app/presentation/components/app_primary_button.dart';
import 'package:enem_app/presentation/components/app_shimmer.dart';
import 'package:enem_app/presentation/controllers/exams/exam_state.dart';
import 'package:enem_app/presentation/controllers/exams/exams_controller.dart';
import 'package:enem_app/presentation/pages/questions/questions_page.dart';
import 'package:flutter/material.dart';

class ExamsPage extends StatefulWidget {

  const ExamsPage({ super.key });

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> with MultipleNotifierMixin {
  final _controller = getIt<ExamsController>();
  final _theme = getIt<AppTheme>();

  @override
  void initState() {
    multiNotifierAction([_controller, _theme]);
    _controller.fetchExams();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
           title: const Text('Exames'), 
           titleTextStyle: AppTextStyle.poppinsW800s24,
           leading: IconButton(
             onPressed: () => context.pop(),
             icon: Icon(Icons.arrow_back_ios_new, size: 25, color: AppColor.white),
           ),
         ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedSwitcher(
               duration: const Duration(milliseconds: 400),
               transitionBuilder: (child, animation) {
                 final offsetAnimation = Tween<Offset>(
                 begin: const Offset(1.0, 0.0),
                 end: Offset.zero,
                 ).animate(
                   CurvedAnimation(
                   parent: animation,
                   curve: Curves.linearToEaseOut,
                 ));
                 
                 return SlideTransition(
                   position: offsetAnimation,
                   child: child,
                 );
               },
                child: switch (_controller.value) {
                  SuccessExamState(:List<ExamEntity> exams) => ListView.builder(
                   key: UniqueKey(),
                   itemCount: exams.length,
                    itemBuilder: (context, index) {
                     final exam = exams[index];
                      return Card(
                       key: ValueKey(UniqueKey()),
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
                                ).centralized(),
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
                                if (exam.languages.isEmpty)
                                  AppPrimaryButton(
                                    text: "Visualizar Questões",
                                    onPressed: () => context.push(
                                      QuestionsPage(
                                        year: exam.year.toString(), 
                                      ),
                                    ),
                                    height: 50,
                                  )
                                else if (exam.languages.length == 1)
                                  AppPrimaryButton(
                                    text: "Prova com ${exam.languages.first.value}",
                                    onPressed: () => context.push(
                                      QuestionsPage(
                                        year: exam.year.toString(), 
                                        discipline: exam.languages.first.value,
                                      ),
                                    ),
                                    height: 50,
                                  )
                                else ...[
                                  AppPrimaryButton(
                                    text: "Prova com Inglês",
                                    onPressed: () => context.push(
                                      QuestionsPage(
                                        year: exam.year.toString(),
                                        discipline: "ingles",
                                      ),
                                    ),
                                    height: 50,
                                  ),
                                  AppPrimaryButton(
                                    text: "Prova com Espanhol",
                                    onPressed: () => context.push(
                                      QuestionsPage(
                                        year: exam.year.toString(),
                                        discipline: "espanhol",
                                      ),
                                    ),
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                  LoadingExamState() => ListView.builder(
                   itemCount: 10,
                   itemBuilder: (context, index) {
                     return Padding(
                       padding: const EdgeInsets.all(8),
                       child: AppShimmer(
                         isRounded: true,
                         height: 400, 
                         width: context.getWidth(),
                       ),
                     );
                   },
                 ),
                  FailureExamState(:String msg) => Text(msg).centralized(),
                  _ => const Text("Erro desconhecido").centralized(),
                },
              ),
            ),
          )
      );
   }
}