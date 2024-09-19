import 'package:enem_app/core/extensions/widget_position_extension.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class ToPraticePage extends StatefulWidget {
  final String year;
  final String? discipline;

  const ToPraticePage({ super.key, required this.year, this.discipline });

  @override
  State<ToPraticePage> createState() => _ToPraticePageState();
}

class _ToPraticePageState extends State<ToPraticePage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            title: const Text('Questão 1'),
            titleTextStyle: AppTextStyle.poppinsW800s24,
            automaticallyImplyLeading: false,
          ),
           body: Column(
            children: [
              Text(widget.year),
              Text(widget.discipline ?? ""),
            ],
           ).centralized(),
       );
  }
}