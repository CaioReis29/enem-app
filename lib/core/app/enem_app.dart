import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/routes/app_routes.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/presentation/pages/exams/exams_page.dart';
import 'package:enem_app/presentation/pages/home/home_page.dart';
import 'package:enem_app/presentation/pages/to_pratice/to_pratice_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnemAPP extends StatelessWidget {
  const EnemAPP({super.key});


  @override
  Widget build(BuildContext context) {
    
  final appTheme = getIt<AppTheme>();

    return ChangeNotifierProvider<AppTheme>(
      create: (_) => appTheme,
      child: Consumer<AppTheme>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Enem App',
            theme: theme.themeData,
            initialRoute: AppRoutes.home,
            routes: {
              AppRoutes.home: (_) => const HomePage(),
              AppRoutes.exams: (_) => const ExamsPage(),
              AppRoutes.toPratice: (_) => const ToPraticePage(),
            },
          );
        }
      ),
    );
  }
}