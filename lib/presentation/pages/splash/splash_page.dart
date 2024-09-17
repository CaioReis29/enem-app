import 'package:enem_app/core/di/container_injections.dart';
import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/mixins/multiple_notifier_mixin.dart';
import 'package:enem_app/core/routes/app_routes.dart';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({ super.key });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with MultipleNotifierMixin{

  final _theme = getIt<AppTheme>();

  @override
  void initState() {
    multiNotifierAction([_theme]);
    initialize();
    super.initState();
  }

  void initialize() async {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      context.pushNamed(AppRoutes.home);
    });
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           body: Column(
            children: [
              Image.asset("assets/enem_flow_logo.png"),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                backgroundColor: AppColor.primary,
                valueColor: AlwaysStoppedAnimation(_theme.isDarkMode ? AppColor.white : AppColor.black),
              ),
            ],
           ).centralized(),
       );
  }
}