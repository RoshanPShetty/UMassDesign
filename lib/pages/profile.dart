import 'package:UMassDesign/comments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:UMassDesign/utils/variables.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uid, username, displaypicture;
  Stream userstream;
  bool present = false;

  initState() {
    super.initState();
    getCurrentUserId();
    getStream();
    getCurrentUserInfo();
  }

  getCurrentUserInfo() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userdoc = await userCollection.doc(firebaseuser.uid).get();
    setState(() {
      username = userdoc.data()['username'];
      displaypicture = userdoc.data()['displaypicture'];
      present = true;
    });
  }

  getStream() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    setState(() {
      userstream = captionCollection
          .where('uid', isEqualTo: firebaseuser.uid)
          .snapshots();
    });
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
        body: present == true
            ? SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Stack(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(color: Colors.purple[700]),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6,
                        left: MediaQuery.of(context).size.width / 2 - 64),
                    child: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(displaypicture)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.9),
                    child: Column(
                      children: <Widget>[
                        Text(username,
                            style:
                                robotoStyle(30, Colors.black, FontWeight.w600)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Following",
                              style: robotoStyle(
                                  20, Colors.black, FontWeight.w600),
                            ),
                            Text(
                              "Followers",
                              style: robotoStyle(
                                  20, Colors.black, FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "12",
                              style: robotoStyle(
                                  20, Colors.black, FontWeight.w600),
                            ),
                            Text(
                              "20",
                              style: robotoStyle(
                                  20, Colors.black, FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.purple[700]),
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style: robotoStyle(
                                    25, Colors.white, FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Posts",
                            style:
                                robotoStyle(25, Colors.black, FontWeight.w700)),
                        StreamBuilder(
                            stream: userstream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot captiondoc =
                                        snapshot.data.documents[index];
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
                                                  captiondoc.data()[
                                                      'displaypicture']),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              captiondoc.data()['username'],
                                              style: robotoStyle(
                                                  20,
                                                  Colors.black,
                                                  FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            if (captiondoc.data()['type'] == 1)
                                              Image(
                                                  image: NetworkImage(captiondoc
                                                      .data()['image'])),
                                            if (captiondoc.data()['type'] == 2)
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    captiondoc
                                                        .data()['caption'],
                                                    style: robotoStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Image(
                                                      image: NetworkImage(
                                                          captiondoc.data()[
                                                              'image'])),
                                                ],
                                              ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () => likePost(
                                                          captiondoc
                                                              .data()['id']),
                                                      child: captiondoc
                                                              .data()['likes']
                                                              .contains(uid)
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : Icon(Icons
                                                              .favorite_border),
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
                                                                builder: (context) =>
                                                                    Comments(captiondoc
                                                                            .data()[
                                                                        'id']))),
                                                        child: Icon(
                                                            Icons.comment)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      captiondoc
                                                          .data()[
                                                              'commentcount']
                                                          .toString(),
                                                      style: robotoStyle(18),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    InkWell(
                                                        onTap: () => sharePosts(
                                                            captiondoc.data()[
                                                                'caption'],
                                                            captiondoc.data()[
                                                                'shares']),
                                                        child:
                                                            Icon(Icons.share)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      captiondoc
                                                          .data()['shares']
                                                          .toString(),
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
                      ],
                    ),
                  ),
                ]),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
