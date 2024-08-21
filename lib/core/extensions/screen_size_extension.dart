import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  Size getSize() {
    return MediaQuery.sizeOf(this);
  }

  double getWidth() {
    return MediaQuery.sizeOf(this).width;
  }

  double getHalfWidth() {
    return MediaQuery.sizeOf(this).width / 2;
  }

  double getHeight() {
    return MediaQuery.sizeOf(this).height;
  }

  double getHalfHeight() {
    return MediaQuery.sizeOf(this).height / 2;
  }
}