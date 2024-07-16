import 'package:birca/view/manual/visitor_manual_3.dart';
import 'package:flutter/material.dart';

class VisitorManual2 extends StatelessWidget{
  const VisitorManual2({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:

             GestureDetector(
              child: Image.asset('lib/assets/image/8.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,),
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const VisitorManual3()),
                );
              },

        )
    );

  }
}