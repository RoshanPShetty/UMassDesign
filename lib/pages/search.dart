import 'package:flutter/material.dart';
import 'package:UMassDesign/utils/variables.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Home',
        style: robotoStyle(30),
      ),
    );
  }
}
