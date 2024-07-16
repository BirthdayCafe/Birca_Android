import 'package:birca/view/manual/owner_manual_2.dart';
import 'package:flutter/material.dart';

class OwnerManual1 extends StatelessWidget{
  const OwnerManual1({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
        GestureDetector(
          child: Image.asset('lib/assets/image/1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
          onTap: (){

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OwnerManual2()),
            );
          },

        )

    );

  }
}