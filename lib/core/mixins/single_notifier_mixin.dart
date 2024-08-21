import 'package:flutter/material.dart';

mixin SingleNotifierMixin<T extends StatefulWidget> on State<T> {
  late Listenable _listenable;

  void notifierAction(Listenable listenable) {
    listenable.addListener(callback);
    _listenable = listenable;
  }

  void callback() => setState((){});

  @override
  void dispose() {
    _listenable.removeListener(callback);
    super.dispose();
  }
}