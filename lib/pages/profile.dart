import 'package:flutter/material.dart';
import 'package:UMassDesign/utils/variables.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: pacificoStyle(30),
        ),
        backgroundColor: Colors.purple[700],
      ),
    );
  }
}
