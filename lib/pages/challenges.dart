import 'package:flutter/material.dart';
import 'package:UMassDesign/utils/variables.dart';

class Challenges extends StatefulWidget {
  @override
  _ChallengesState createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Challenges',
          style: pacificoStyle(30),
        ),
        backgroundColor: Colors.purple[700],
      ),
    );
  }
}
