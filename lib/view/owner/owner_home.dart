
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerHome();
}

class _OwnerHome extends State<OwnerHome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
    );

  }

}