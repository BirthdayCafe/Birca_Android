import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServicePolicy extends StatelessWidget {
  const ServicePolicy({super.key});

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
        body: const SingleChildScrollView(
          child: Text('서비스 이용 약관'),
        ));
  }
}
