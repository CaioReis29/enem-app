import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/single_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/domain/entities/exams/exam_entity.dart';
import 'package:enem_app/domain/entities/exams/language_entity.dart';
import 'package:enem_app/presentation/components/app_primary_button.dart';
import 'package:enem_app/presentation/components/app_shimmer.dart';
import 'package:enem_app/presentation/controllers/to_pratice/to_pratice_controller.dart';
import 'package:enem_app/presentation/controllers/to_pratice/to_pratice_state.dart';
import 'package:enem_app/presentation/pages/to_pratice/to_pratice_page.dart';
import 'package:flutter/material.dart';

class SelectOptionsToPraticePage extends StatefulWidget {

  const SelectOptionsToPraticePage({ super.key });

  @override
  State<SelectOptionsToPraticePage> createState() => _SelectOptionsToPraticePageState();
}

class _SelectOptionsToPraticePageState extends State<SelectOptionsToPraticePage> with SingleNotifierMixin {

  final _controller = getIt<ToPraticeController>();

  ExamEntity? selectedExam;
  List<LanguageEntity>? examLanguages;
  String? selectedLanguage;
  String? selectedLevel;

  List<String> examLevels = ["Fácil", "Difícil"];

  @override
  void initState() {
    notifierAction(_controller);
    _controller.fetchExams();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            title: const Text('Praticar questões'), 
            titleTextStyle: AppTextStyle.poppinsW800s24,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back_ios_new, size: 25, color: AppColor.white),
            ),
          ),
           body: switch (_controller.value) {
             SuccessToPraticeState(:List<ExamEntity> exams) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Selecione o exame", style: AppTextStyle.poppinsW500s24),
                    const SizedBox(height: 20),
                    DropdownButton<ExamEntity>(
                      value: selectedExam,
                      hint: const Text("Selecione a edição"),
                      items: exams.map((ExamEntity value) {
                        return DropdownMenuItem<ExamEntity>(
                          value: value,
                          child: Text(value.title),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedExam = newValue;
                          examLanguages = newValue?.languages;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Text("Linguagem", style: AppTextStyle.poppinsW500s24),
                    const SizedBox(height: 20),
                    if(
                      selectedExam != null 
                      && examLanguages != null 
                      && examLanguages!.isNotEmpty
                      ) ... [
                      ...examLanguages!.map((LanguageEntity language) {
                        return RadioListTile<String>(
                          title: Text(language.label, style: AppTextStyle.poppinsW400s18),
                          value: language.value,
                          activeColor: AppColor.primary,
                          groupValue: selectedLanguage,
                          onChanged: (String? value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 30),
                      Text("Nível de dificuldade", style: AppTextStyle.poppinsW500s24),
                      const SizedBox(height: 20),
                    ],
                    ...examLevels.map((String exam) {
                      return RadioListTile<String>(
                        title: Text(exam, style: AppTextStyle.poppinsW400s18),
                        value: exam,
                        activeColor: AppColor.primary,
                        groupValue: selectedLevel,
                        onChanged: (String? value) {
                          setState(() {
                            selectedLevel = value;
                          });
                        },
                      );
                    }),
                    const SizedBox(height: 30),
                    AppPrimaryButton(
                      text: "Confirmar", 
                      textStyle: AppTextStyle.poppinsW800s24.copyWith(color: AppColor.white),
                      onPressed: 
                      selectedExam != null && examLanguages != null && selectedLevel != null
                      || selectedExam != null && examLanguages!.isEmpty && selectedLevel != null
                      ? () {
                        context.pushReplacement(ToPraticePage(year: selectedExam!.year.toString(), discipline: selectedLanguage));
                      }
                      : null,
                    ),
                  ],
                ),
              ),
            ),
            LoadingToPraticeState() => Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppShimmer(height: 40, width: 220),
                    const SizedBox(height: 20),
                    const AppShimmer(height: 40, width: 170),
                    const SizedBox(height: 30),
                    const AppShimmer(height: 40, width: 150),
                    const SizedBox(height: 20),
                    const AppShimmer(height: 40, width: 150),
                    const SizedBox(height: 20),
                    const AppShimmer(height: 40, width: 150),
                    const SizedBox(height: 30),
                    const AppShimmer(height: 40, width: 150),
                    const SizedBox(height: 20),
                    const AppShimmer(height: 40, width: 150),
                    const SizedBox(height: 20),
                    const AppShimmer(height: 40, width: 150),
                    const SizedBox(height: 30),
                    AppShimmer(height: 60, width: context.getWidth(), borderRadius: BorderRadius.circular(15)),
                  ],
                ),
              ),
            ),
            FailureToPraticeState(:String msg) => Text(msg).centralized(),
            _ => const Text("Erro desconhecido").centralized(),
           }
       );
  }
}