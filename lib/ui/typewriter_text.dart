import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypeWriterText extends StatelessWidget {
  final List<String> text;
  final TextStyle style;
  final Function() onTap;

  TypeWriterText(this.text, {@required this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      text: text,
      textStyle: style,
      totalRepeatCount: 1,
      speed: Duration(milliseconds: 150),
      onTap: onTap,
    );
  }
}
