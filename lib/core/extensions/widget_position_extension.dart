import 'package:flutter/material.dart';

extension WidgetCentererExtension on Widget {
  Widget centralized() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [this],
      ),
    );
  }

  Widget side(Alignment aligment) {
    return Align(alignment: aligment, child: this);
  }
}
