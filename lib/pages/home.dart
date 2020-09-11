import 'package:UMassDesign/addPost.dart';
import 'package:UMassDesign/comments.dart';
import 'package:UMassDesign/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid;
  initState() {
    super.initState();
    getCurrentUserId();
  }

  getCurrentUserId() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    setState(() {
      uid = firebaseuser.uid;
    });
  }

  likePost(String documentid) async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot document = await captionCollection.doc(documentid).get();

    if (document.data()['likes'].contains(firebaseuser.uid)) {
      captionCollection.doc(documentid).update({
        'likes': FieldValue.arrayRemove([firebaseuser.uid])
      });
    } else {
      captionCollection.doc(documentid).update({
        'likes': FieldValue.arrayUnion([firebaseuser.uid])
      });
    }
  }

  //This is not working as it says
  //Error - type 'int' is not a subtype of type 'String'
  //Check it out later
  sharePosts(String caption, String documentid) async {
    Share.text('UMass Design', caption, 'text/plain');
    DocumentSnapshot document = await captionCollection.doc(documentid).get();
    captionCollection
        .doc(documentid)
        .update({'shares': document.data()['shares'] + 1});
  }

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
            Icons.info,
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
      body: StreamBuilder(
          stream: captionCollection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot captiondoc = snapshot.data.documents[index];
                  return Card(
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   backgroundImage:
                      //       NetworkImage(captiondoc.data()['displaypicture']),
                      // ),
                      title: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                captiondoc.data()['displaypicture']),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            captiondoc.data()['username'],
                            style:
                                robotoStyle(20, Colors.black, FontWeight.w700),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (captiondoc.data()['type'] == 1)
                            Image(
                                image:
                                    NetworkImage(captiondoc.data()['image'])),
                          if (captiondoc.data()['type'] == 2)
                            Column(
                              children: <Widget>[
                                Text(
                                  captiondoc.data()['caption'],
                                  style: robotoStyle(
                                      20, Colors.black, FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image(
                                    image: NetworkImage(
                                        captiondoc.data()['image'])),
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () =>
                                        likePost(captiondoc.data()['id']),
                                    child:
                                        captiondoc.data()['likes'].contains(uid)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(Icons.favorite_border),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    captiondoc
                                        .data()['likes']
                                        .length
                                        .toString(),
                                    style: robotoStyle(18),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Comments(
                                                  captiondoc.data()['id']))),
                                      child: Icon(Icons.comment)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    captiondoc
                                        .data()['commentcount']
                                        .toString(),
                                    style: robotoStyle(18),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                      onTap: () => sharePosts(
                                          captiondoc.data()['caption'],
                                          captiondoc.data()['shares']),
                                      child: Icon(Icons.share)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    captiondoc.data()['shares'].toString(),
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
                });
          }),
    );
  }
}
