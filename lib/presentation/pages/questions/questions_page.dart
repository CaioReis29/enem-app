import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/single_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/presentation/controllers/questions/questions_controller.dart';
import 'package:enem_app/presentation/controllers/questions/questions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuestionsPage extends StatefulWidget {
  final String year;
  final String? discipline;

  const QuestionsPage({ super.key, required this.year, this.discipline });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> with SingleNotifierMixin {
  final _controller = getIt<QuestionsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    notifierAction(_controller);
    _controller.addListener((){
      if(_controller.value is SuccessQuestionsState) {
        setState(() {});
      } else if(_controller.value is SuccessPaginationState) {
        setState(() {});
      }
    });
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
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Questões')),
           body: SafeArea(
            child: switch (_controller.value) {
              LoadingQuestionsState() => CircularProgressIndicator
                  .adaptive(
                    backgroundColor: AppColor.primary,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ).centralized(),
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
                      final content = parseContent(question.context ?? "", context);
                      return Card(
                        elevation: 4,
                        shadowColor: AppColor.white,
                        color: AppColor.grey,
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
                                    child: Text(question.language ?? ""),
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
                                              child: Text(" ${a.letter} ", style: AppTextStyle.poppinsW500s20),
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
                            valueColor: const AlwaysStoppedAnimation(Colors.white),
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

  List<Widget> parseContent(String context, BuildContext c) {
    final List<Widget> contentWidgets = [];
    final RegExp regex = RegExp(r"!\[.*?\]\((.*?)\)");

    final Iterable<RegExpMatch> matches = regex.allMatches(context);
    int previousEnd = 0;

    for (final match in matches) {
      if (match.start > previousEnd) {
        contentWidgets.add(Text(context.substring(previousEnd, match.start), style: AppTextStyle.poppinsW600s18));
      }

      final String? imageUrl = match.group(1);
      if (imageUrl != null) {
        if (imageUrl.endsWith('.svg')) {
          contentWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SvgPicture.network(
              imageUrl, height: 
              c.getHeight() * 0.4, 
              width: c.getWidth(),
              fit: BoxFit.fill,
            ),
          ));
        } else {
          contentWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.network(
              imageUrl, 
              height: c.getHeight() * 0.4, 
              width: c.getWidth(),
              fit: BoxFit.fill,
            ),
          ));
        }
      }

      previousEnd = match.end;
    }

    if (previousEnd < context.length) {
      contentWidgets.add(Text(context.substring(previousEnd), style: AppTextStyle.poppinsW400s18));
    }

    return contentWidgets;
  }
}