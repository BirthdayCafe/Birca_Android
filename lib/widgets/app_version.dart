import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

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
          child: const Text(
            '앱 버전: 1.0.0',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
