import 'package:flutter/material.dart';
import 'package:UMassDesign/utils/variables.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Leaderboard',
        style: robotoStyle(30),
      ),
    );
  }
}
