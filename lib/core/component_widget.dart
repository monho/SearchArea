import 'package:flutter/material.dart';

class TermsHeaderText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TermsHeaderText({
    super.key,
    required this.text, // 필수 파라미터
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style ??
          const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(68, 68, 68, 1),
          ), // 기본 스타일 제공
      textAlign: textAlign,
    );
  }
}
