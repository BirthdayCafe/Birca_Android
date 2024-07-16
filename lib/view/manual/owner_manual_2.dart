import 'package:birca/view/manual/owner_manual_3.dart';
import 'package:flutter/material.dart';

class OwnerManual2 extends StatelessWidget{
  const OwnerManual2({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
            child: Image.asset('lib/assets/image/2.png',
              fit: BoxFit.cover,
             ),
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const OwnerManual3()),
              );
            },

          )
        )


    );

  }
}