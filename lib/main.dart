import 'package:enem_app/core/app/enem_app.dart';
import 'package:enem_app/core/di/container_injections.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await setUpContainer();

  runApp(const EnemAPP());
}