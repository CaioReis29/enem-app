import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/multiple_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/core/utils/enem_utils.dart';
import 'package:enem_app/domain/entities/questions/questions_entity.dart';
import 'package:enem_app/presentation/components/app_primary_button.dart';
import 'package:enem_app/presentation/controllers/pratice/pratice_controller.dart';
import 'package:enem_app/presentation/controllers/pratice/pratice_state.dart';
import 'package:enem_app/presentation/pages/pratice/widgets/count_donw_popup.dart';
import 'package:enem_app/presentation/pages/pratice/widgets/custom_progress_bar.dart';
import 'package:flutter/material.dart';

class ToPraticePage extends StatefulWidget {
  final String year;
  final String? discipline;

  const ToPraticePage({super.key, required this.year, this.discipline});

  @override
  State<ToPraticePage> createState() => _ToPraticePageState();
}

class _ToPraticePageState extends State<ToPraticePage> with MultipleNotifierMixin {
  final _controller = getIt<PraticeController>();
  final _theme = getIt<AppTheme>();
  bool _dialogShown = false;

  String? _selectedAlternativeLetter;

  @override
  void initState() {
    multiNotifierAction([_theme, _controller]);
    _controller.loadQuestion(widget.year, language: widget.discipline);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const CountdownPopup(countdownTime: 5);
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: switch (_controller.value) {
          LoadingPraticeState() => const Text('Carregando...'),
          FailurePraticeState(msg: String _) => const Text('Error'),
          LoadedQuestionState(:QuestionsEntity questions) => Text(questions.questions.first.title),
          _ => const Text('Pratice'),
        },
        titleTextStyle: AppTextStyle.poppinsW800s24,
        automaticallyImplyLeading: false,
      ),
      body: switch (_controller.value) {
        LoadingPraticeState() => CircularProgressIndicator(
          backgroundColor: AppColor.primary,
          valueColor: AlwaysStoppedAnimation(_theme.isDarkMode ? AppColor.white : AppColor.black),
        ).centralized(),
        FailurePraticeState(:String msg) => Text(msg).centralized(),
        LoadedQuestionState(:QuestionsEntity questions) => Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              CustomProgressBar(
                totalValue: 180,
                currentValue: questions.questions.first.index, 
                progress: questions.questions.first.index / 180, 
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Column(
                          children: EnemUtils.parseContent(
                            questions.questions.first.context ?? "", 
                            context,
                          ),
                        ),
                        if (questions.questions.first.alternativesIntroduction != null) ... [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text("- ${questions.questions.first.alternativesIntroduction ?? ""}", style: AppTextStyle.poppinsW500s20),
                          ),
                        ],
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: questions.questions.first.alternatives.map((a) {
                            final isSelected = _selectedAlternativeLetter == a.letter;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAlternativeLetter = a.letter;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.fromBorderSide(BorderSide(
                                    color: isSelected
                                        ? Colors.blue 
                                        : (_theme.isDarkMode ? Colors.white : Colors.black),
                                    width: 2,
                                  )),
                                ),
                                child: Text.rich(
                                  style: AppTextStyle.poppinsW500s18,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: " ${a.letter}. ", 
                                        style: AppTextStyle.poppinsW700s20,
                                      ),
                                      TextSpan(text: a.text),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        AppPrimaryButton(
                          text: questions.questions.first.index == 180
                                ? "Finalizar"
                                : "Confirmar",
                          textStyle: AppTextStyle.poppinsW800s24.copyWith(color: AppColor.white),
                          onPressed: _selectedAlternativeLetter != null
                            ? () {
                              questions.questions.first.index == 180
                                ? context.pop()
                                : _controller.loadNextQuestion(widget.year, language: widget.discipline);
                              setState(() {
                                _selectedAlternativeLetter = null;
                              });
                            }
                            : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
