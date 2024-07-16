import 'package:birca/widgets/bottom_nav_host.dart';
import 'package:flutter/material.dart';

class HostManual3 extends StatelessWidget{
  const HostManual3({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
        GestureDetector(
          child:  SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:   Image.asset('lib/assets/image/6.png',
              fit: BoxFit.cover,
             ),
          ),
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavHost()),
            );
          },

        )

    );

  }
}