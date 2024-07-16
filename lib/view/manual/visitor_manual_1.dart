import 'package:birca/view/manual/visitor_manual_2.dart';
import 'package:flutter/material.dart';

class VisitorManual1 extends StatelessWidget{
  const VisitorManual1({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:
          GestureDetector(
            child:  SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:   Image.asset('lib/assets/image/7.png',
                fit: BoxFit.cover,

                ),
            ),
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