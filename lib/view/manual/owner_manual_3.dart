import 'package:birca/widgets/bottom_nav_owner.dart';
import 'package:flutter/material.dart';

class OwnerManual3 extends StatelessWidget{
  const OwnerManual3({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GestureDetector(
                child: Image.asset('lib/assets/image/3.png',
                  fit: BoxFit.cover,
               ),
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BottomNavOwner()),
                  );
                },

              )
            )


    );

  }
}