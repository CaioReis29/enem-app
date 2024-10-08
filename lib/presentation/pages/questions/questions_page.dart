import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/multiple_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/core/utils/enem_utils.dart';
import 'package:enem_app/presentation/components/app_shimmer.dart';
import 'package:enem_app/presentation/controllers/questions/questions_controller.dart';
import 'package:enem_app/presentation/controllers/questions/questions_state.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  final String year;
  final String? discipline;

  const QuestionsPage({ super.key, required this.year, this.discipline });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> with MultipleNotifierMixin {
  final _controller = getIt<QuestionsController>();
  final _theme = getIt<AppTheme>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    multiNotifierAction([_controller, _theme]);
    _controller.fetchQuestions(widget.year, language: widget.discipline);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (_controller.hasMore) {
          _controller.pagination(widget.year, language: widget.discipline);
        }
      }
    });
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            title: const Text('Questões'), 
            titleTextStyle: AppTextStyle.poppinsW800s24,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back_ios_new, size: 25, color: AppColor.white),
            ),
          ),
           body: SafeArea(
            child: switch (_controller.value) {
              LoadingQuestionsState() => ListView.builder(
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
              FailureQuestionsState(:String msg) => Text(msg).centralized(),
              _ => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _controller.hasMore 
                    ? _controller.questionEntity.questions.length + 1 
                    : _controller.questionEntity.questions.length,
                  itemBuilder: (context, index) {
                    if (index < _controller.questionEntity.questions.length) {
                      final question = _controller.questionEntity.questions[index];
                      final content = EnemUtils.parseContent(question.context ?? "", context);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(question.title, style: AppTextStyle.poppinsW800s24).centralized(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${question.discipline}"),
                                  if (question.language != null) const Text(" - "),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: question.language != null ? AppColor.redPrimary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(question.language ?? "", style: TextStyle(color: AppColor.white)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Column(
                                children: content,
                              ),
                              if (question.alternativesIntroduction != null) ... [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Text("- ${question.alternativesIntroduction ?? ""}", style: AppTextStyle.poppinsW500s20),
                                ),
                              ],
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: question.alternatives.map((a) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text.rich(
                                      style: AppTextStyle.poppinsW500s18,
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: a.isCorrect ? Colors.green : AppColor.primary,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(" ${a.letter} ", style: AppTextStyle.poppinsW500s20.copyWith(color: AppColor.white)),
                                            ),
                                          ),
                                          TextSpan(
                                            text: " ${a.text}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColor.primary,
                            valueColor: AlwaysStoppedAnimation(_theme.isDarkMode ? AppColor.white : AppColor.black),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            }
           ),
       );
  }
}