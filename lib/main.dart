import 'package:enem_app/core/app/enem_app.dart';
import 'package:enem_app/core/container_injections.dart';
import 'package:flutter/material.dart';

void main() async{
  await setUpContainer();

  runApp(const EnemAPP());
}