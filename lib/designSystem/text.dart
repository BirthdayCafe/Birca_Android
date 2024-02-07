import 'package:flutter/cupertino.dart';

class BircaText extends StatelessWidget {
  final String text;
  final int textSize;
  final Color textColor;
  final String fontFamily;

  const BircaText({
    super.key,
    required this.text,
    required this.textSize,
    required this.textColor,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: textSize.toDouble(),
          fontFamily: fontFamily),
    );
  }
}
