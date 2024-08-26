import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {

  void pop() {
    Navigator.pop(this);
  }

  void push(Widget widgetRoute) {
    Navigator.push(
      this, 
      MaterialPageRoute(builder: (context) => widgetRoute),
    );
  }

  void pushReplacement(Widget widgetRoute) {
    Navigator.pushReplacement(
      this, 
      MaterialPageRoute(builder: (context) => widgetRoute),
    );
  }

  void pushNamed(String route) {
    Navigator.pushNamed(
      this, 
      route,
    );
  }

  void pushReplacementNamed(String route) {
    Navigator.pushReplacementNamed(
      this, 
      route,
    );
  }
}