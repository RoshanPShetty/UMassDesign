import 'package:UMassDesign/addPost.dart';
import 'package:UMassDesign/utils/variables.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[700],
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPost())),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: <Widget>[
          Icon(
            Icons.star,
            size: 32,
          ),
        ],
        backgroundColor: Colors.purple[700],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "UMass Design",
              style: pacificoStyle(30, Colors.white, FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            // Image(
            //   width: 45,
            //   image: AssetImage('images/Logo.png'),
            // ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(sampleProfile),
                ),
                title: Text(
                  "Roshan",
                  style: robotoStyle(20, Colors.black, FontWeight.w600),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Text(
                      "This is a good design",
                      style: robotoStyle(20, Colors.black, FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.favorite_border),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "4",
                              style: robotoStyle(18),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.comment),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "4",
                              style: robotoStyle(18),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.send),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "4",
                              style: robotoStyle(18),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
