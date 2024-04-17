
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnerChatting extends StatefulWidget {
  const OwnerChatting({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerChatting();
}

class _OwnerChatting extends State<OwnerChatting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chatting"),
      ),
    );
  }

}