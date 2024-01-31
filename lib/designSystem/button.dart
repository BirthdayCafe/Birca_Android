
import 'package:flutter/material.dart';

class BircaElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final int width;
  final int height;

  const BircaElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.color,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width.toDouble(),
        height: height.toDouble(),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color)
          ),
          onPressed: onPressed,
          child: Text(text),
        )
    );
  }
}

class BircaIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? label;
  final int width;
  final int height;

  const BircaIconButton({
    super.key,
    required this.icon,
    required this.width,
    required this.height,
    this.onPressed,
    this.color,
    this.label
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width.toDouble(),
        height: height.toDouble(),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        )
    );
  }
}

class BircaFilledButton extends StatelessWidget{

  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final int width;
  final int height;

  const BircaFilledButton({super.key,
    required this.text,
    required this.color,
    required this.width,
    required this.height,
    this.onPressed,
}

      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.toDouble(),
      height: height.toDouble(),
      child: FilledButton(
        onPressed: onPressed,
        child:Text(text),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color)

        )

    ),
    );
  }

}

class BircaOutLinedButton extends StatelessWidget{

  final String text;
  final VoidCallback? onPressed;
  final Color radiusColor;
  final Color textColor;
  final int width;
  final int height;
  final int radius;

  const BircaOutLinedButton({super.key,
    required this.text,
    required this.radiusColor,
    required this.width,
    required this.height,
    required this.radius,
    required this.textColor,
    this.onPressed,
  }

      );

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width.toDouble(),
      height: height.toDouble(),
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: radiusColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius.toDouble())
            )
          ),
          child:Text(text,
          style: TextStyle(
            color: textColor
          ),)

      ),
    );
  }

}