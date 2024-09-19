import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/mixins/single_notifier_mixin.dart';
import 'package:enem_app/core/routes/app_routes.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:enem_app/presentation/components/app_primary_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleNotifierMixin {
  final theme = getIt<AppTheme>();

  @override
  void initState() {
    notifierAction(theme);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          theme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: theme.isDarkMode ? AppColor.black : AppColor.lightBackground,
        ),
        onPressed: () => theme.toggleTheme(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/enem_flow.png", 
                height: context.getHeight() * 0.4,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              AppPrimaryButton(
                text: "Visualizar lista de exames", 
                onPressed: () => context.pushNamed(AppRoutes.exams),
              ),
              AppPrimaryButton(
                text: "Praticar questões",
                onPressed: () => context.pushNamed(AppRoutes.selectOptionsToPratice),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Developed by Caio Reis"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
