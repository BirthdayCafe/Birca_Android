import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<StatefulWidget> createState() => _Contact();
}

class _Contact extends State<Contact> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('lib/assets/image/ic_back.svg')),
      ),
      body: Container(

        alignment: Alignment.center,

        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('E-mail : tmdrbs8846@gmail.com',style: TextStyle(
              fontSize: 20
            ),),
            Text('Phone : 010-6642-8846',style: TextStyle(
                fontSize: 20
            ))

          ],
        ),
      ),
    );
  }
}
