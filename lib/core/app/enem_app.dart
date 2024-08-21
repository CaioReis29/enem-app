import 'package:enem_app/core/routes/app_routes.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/presentation/pages/exams/exams_page.dart';
import 'package:enem_app/presentation/pages/home/home_page.dart';
import 'package:enem_app/presentation/pages/questions/questions_page.dart';
import 'package:enem_app/presentation/pages/to_pratice/to_pratice_page.dart';
import 'package:flutter/material.dart';

class EnemAPP extends StatelessWidget {
  const EnemAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enem App',
      theme: AppTheme.enemTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.exams: (_) => const ExamsPage(),
        AppRoutes.questions: (_) => const QuestionsPage(),
        AppRoutes.toPratice: (_) => const ToPraticePage(),
      },
    );
  }
}