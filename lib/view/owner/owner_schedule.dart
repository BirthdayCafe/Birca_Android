
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnerSchedule extends StatefulWidget {
  const OwnerSchedule({super.key});

  @override
  State<StatefulWidget> createState() => _OwnerSchedule();
}

class _OwnerSchedule extends State<OwnerSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("schedule"),
      ),
    );
  }

}