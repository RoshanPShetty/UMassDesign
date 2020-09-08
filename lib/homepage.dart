import 'package:UMassDesign/pages/challenges.dart';
import 'package:UMassDesign/pages/home.dart';
import 'package:UMassDesign/pages/leaderboard.dart';
import 'package:UMassDesign/pages/profile.dart';
import 'package:UMassDesign/pages/search.dart';
import 'package:UMassDesign/utils/variables.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNumber = 0;
  List pages = [Home(), Search(), Challenges(), LeaderBoard(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageNumber],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              pageNumber = index;
            });
          },
          currentIndex: pageNumber,
          selectedItemColor: Colors.purple[700],
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 25,
                ),
                title: Text(
                  'Home',
                  style: robotoStyle(20),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 32,
                ),
                title: Text(
                  'Search',
                  style: robotoStyle(20),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment,
                  size: 32,
                ),
                title: Text(
                  'Challenges',
                  style: robotoStyle(20),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.equalizer,
                  size: 32,
                ),
                title: Text(
                  'Rank',
                  style: robotoStyle(20),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 32,
                ),
                title: Text(
                  'Profile',
                  style: robotoStyle(20),
                )),
          ]),
    );
  }
}
