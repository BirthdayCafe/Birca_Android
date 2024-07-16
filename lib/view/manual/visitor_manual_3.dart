import 'package:birca/view/manual/visitor_manual_4.dart';
import 'package:flutter/material.dart';

class VisitorManual3 extends StatelessWidget{
  const VisitorManual3({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
           GestureDetector(
            child: Image.asset('lib/assets/image/9.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VisitorManual4()),
              );
            },
          )


    );

  }
}