import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/multiple_notifier_mixin.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/presentation/controllers/pratice/pratice_controller.dart';
import 'package:enem_app/presentation/controllers/pratice/pratice_state.dart';
import 'package:enem_app/presentation/pages/pratice/widgets/count_donw_popup.dart';
import 'package:flutter/material.dart';

class ToPraticePage extends StatefulWidget {
  final String year;
  final String? discipline;

  const ToPraticePage({ super.key, required this.year, this.discipline });

  @override
  State<ToPraticePage> createState() => _ToPraticePageState();
}

class _ToPraticePageState extends State<ToPraticePage> with MultipleNotifierMixin {

  final _controller = getIt<PraticeController>();
  final _theme = getIt<AppTheme>();

  bool _dialogShown = false;

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
    
    final question = _controller.questionEntity.questions.first;

       return Scaffold(
           appBar: AppBar(
            title: Text(question.title),
            titleTextStyle: AppTextStyle.poppinsW800s24,
            automaticallyImplyLeading: false,
          ),
           body: switch (_controller.value) {
             LoadingPraticeState() => const CircularProgressIndicator().centralized(),
             FailurePraticeState(:String msg) => Text(msg).centralized(),
             _ => Column(
              children: [
                Text(question.year.toString(), style: AppTextStyle.poppinsW800s45,).centralized(),
              ],
             ),
           }
       );
  }
}