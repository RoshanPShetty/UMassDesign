import 'package:flutter/material.dart';
import 'package:UMassDesign/utils/variables.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Profile',
        style: robotoStyle(30),
      ),
    );
  }
}
