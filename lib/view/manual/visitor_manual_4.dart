import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_visitor.dart';

class VisitorManual4 extends StatelessWidget{
  const VisitorManual4({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
            GestureDetector(
            child: Image.asset('lib/assets/image/10.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
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