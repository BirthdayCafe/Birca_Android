import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BircaText extends StatelessWidget{

  final String text;
  final int textSize;
  final Color textColor;
  final String fontFamily;

  const BircaText({
    required this.text,
    required this.textSize,
    required this.textColor,
    required this.fontFamily,
});

  @override
  Widget build(BuildContext context) {
   return Text(text,
   style: TextStyle(
     color: textColor,
     fontSize: textSize.toDouble(),
     fontFamily: fontFamily
   ),
   );

  }

}

//밑줄 textfield
class BircaUnderLineTextField extends StatelessWidget{

  final int textSize;
  final Color borderColor;
  final String hint;

  const BircaUnderLineTextField({

 required this.textSize, required this.borderColor, required this.hint});

  @override
  Widget build(BuildContext context) {

    return TextField(
        // textAlign: TextAlign.end,
        style: TextStyle(fontSize: textSize.toDouble()),
        decoration: InputDecoration(
          isDense: true,

          contentPadding: EdgeInsets.zero,
          //비활성화
          enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor)),
          hintText: hint,

          //활성화
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: MainColors.main03)
          // )
        ),

    );
  }


}