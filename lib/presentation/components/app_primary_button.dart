import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    this.child,
    this.style,
    required this.text,
    this.onPressed,
    this.textStyle,
    this.height,
    this.isLoading = false,
    this.prefixWidget,
    this.suffixWidget,
    this.mainAxisAlignment,
  });

  final Widget? child;
  final ButtonStyle? style;
  final String text;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final double? height;
  final bool isLoading;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final heightButton = height ?? 55;
    final hasWidget = prefixWidget != null || suffixWidget != null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: heightButton,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? SizedBox(width: heightButton - 30, height: heightButton - 30, child: const CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: mainAxisAlignment ?? (hasWidget ? MainAxisAlignment.start : MainAxisAlignment.center),
                  children: [
                    if (prefixWidget != null) ...[prefixWidget!, const SizedBox(width: 10)],
                    Expanded(
                      flex: hasWidget ? 0 : 1, 
                      child: child ?? Text(
                        text, 
                        style: textStyle ?? Theme.of(context).primaryTextTheme.bodyMedium, 
                        textAlign: TextAlign.center,
                        ),
                      ),
                    if (suffixWidget != null) ...[
                      const Spacer(),
                      const SizedBox(width: 10),
                      suffixWidget!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
