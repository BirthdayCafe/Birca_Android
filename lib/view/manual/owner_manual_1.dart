import 'package:flutter/material.dart';

import 'owner_manual_2.dart';

class OwnerManual1 extends StatelessWidget{
  const OwnerManual1({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
        GestureDetector(
          child:
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:   Image.asset('lib/assets/image/1.png',
                  fit: BoxFit.cover,
               ),
              ),

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