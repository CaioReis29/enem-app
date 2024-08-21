import 'package:flutter/material.dart';

mixin MultipleNotifierMixin<T extends StatefulWidget> on State<T> {
  List<Listenable> _listenables = [];

  void multiNotifierAction(List<Listenable> listenables) {
    for(int i = 0; i < listenables.length; i++) {
      listenables[i].addListener(callback);
    }
    _listenables = listenables;
  }

  void callback() => setState((){});

  @override
  void dispose() {
    for(int i = 0; i < _listenables.length; i++) {
      _listenables[i].removeListener(callback);
    }
    _listenables.clear();
    super.dispose();
  }
}