import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_visitor.dart';

class VisitorManual4 extends StatelessWidget{
  const VisitorManual4({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
            GestureDetector(
            child:  SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:   Image.asset('lib/assets/image/10.png',
                fit: BoxFit.cover,
                ),
            ),
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BottomNavVisitor()),
              );
            },
          )


    );

  }
}