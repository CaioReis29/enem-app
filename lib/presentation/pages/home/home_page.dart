import 'package:enem_app/core/extensions/navigator_extension.dart';
import 'package:enem_app/core/extensions/screen_size_extension.dart';
import 'package:enem_app/core/routes/app_routes.dart';
import 'package:enem_app/presentation/components/app_primary_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/enem_logo.png", 
                height: context.getHeight() * 0.4,
              ),
              const SizedBox(height: 10),
              AppPrimaryButton(
                text: "Visualizar lista de exames", 
                onPressed: () => context.pushNamed(AppRoutes.exams),
              ),
              AppPrimaryButton(
                text: "Visualizar questões",
                onPressed: () {},
              ),
              AppPrimaryButton(
                text: "Praticar questões",
                onPressed: () {},
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
