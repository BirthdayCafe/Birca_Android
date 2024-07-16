import 'package:birca/view/manual/owner_manual_3.dart';
import 'package:flutter/material.dart';

class OwnerManual2 extends StatelessWidget{
  const OwnerManual2({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
        GestureDetector(
          child: Image.asset('lib/assets/image/2.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OwnerManual3()),
            );
          },

        )

    );

  }
}