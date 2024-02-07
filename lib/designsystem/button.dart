import 'package:flutter/material.dart';

class BircaButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final Color color;
  final int width;
  final int height;

  const BircaButton(
      {super.key,
      this.label,
      this.onPressed,
      required this.color,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width.toDouble(),
        height: height.toDouble(),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color)),
          onPressed: onPressed,
          child: Text(label!),
        ));
  }
}

class BircaIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? label;
  final int width;
  final int height;

  const BircaIconButton(
      {super.key,
      required this.icon,
      required this.width,
      required this.height,
      this.onPressed,
      this.color,
      this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width.toDouble(),
        height: height.toDouble(),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ));
  }
}
