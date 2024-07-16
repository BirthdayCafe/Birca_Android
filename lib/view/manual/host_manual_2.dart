import 'package:birca/view/manual/host_manual_3.dart';
import 'package:flutter/material.dart';

class HostManual2 extends StatelessWidget{
  const HostManual2({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
        GestureDetector(
          child: Image.asset('lib/assets/image/5.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HostManual3()),
            );
          },

        )

    );

  }
}