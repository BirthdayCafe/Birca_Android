
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnerMypage extends StatefulWidget {
  const OwnerMypage({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerMypage();
}

class _OwnerMypage extends State<OwnerMypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mypage"),
      ),
    );
  }

}