import 'dart:async';
import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class CountdownPopup extends StatefulWidget {
  final int countdownTime;

  const CountdownPopup({super.key, required this.countdownTime});

  @override
  _CountdownPopupState createState() => _CountdownPopupState();
}

class _CountdownPopupState extends State<CountdownPopup> with SingleTickerProviderStateMixin {
  late int _currentCountdown;
  late Timer _timer;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _currentCountdown = widget.countdownTime;
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentCountdown > 0) {
        setState(() {
          _currentCountdown--;
        });
      } else {
        _closePopup();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _closePopup() {
    _timer.cancel();
    setState(() {
      _opacity = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 400),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Atenção!",
                style: AppTextStyle.poppinsW800s24,
              ),
              const SizedBox(height: 20),
              Text(
                "Começa em:",
                style: AppTextStyle.poppinsW600s20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                _currentCountdown.toString(),
                style: AppTextStyle.poppinsW800s45.copyWith(color: AppColor.redPrimary),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
