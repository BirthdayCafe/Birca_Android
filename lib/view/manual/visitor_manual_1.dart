import 'package:birca/view/manual/visitor_manual_2.dart';
import 'package:flutter/material.dart';

class VisitorManual1 extends StatelessWidget{
  const VisitorManual1({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:
          GestureDetector(
            child: Image.asset('lib/assets/image/7.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VisitorManual2()),
              );
            },

      )

    );

  }
}