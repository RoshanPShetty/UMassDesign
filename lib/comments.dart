import 'package:UMassDesign/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tago;

class Comments extends StatefulWidget {
  final String documentid;
  Comments(this.documentid);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var commentController = TextEditingController();

  addComment() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userdoc = await userCollection.doc(firebaseuser.uid).get();
    captionCollection.doc(widget.documentid).collection('comments').doc().set({
      'comment': commentController.text,
      'username': userdoc.data()['username'],
      'uid': userdoc.data()['uid'],
      'displaypicture': userdoc.data()['displaypicture'],
      'time': DateTime.now()
    });
    DocumentSnapshot commentcount =
        await captionCollection.doc(widget.documentid).get();
    captionCollection
        .doc(widget.documentid)
        .update({'commentcount': commentcount.data()['commentcount'] + 1});
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.purple[700],
      //   centerTitle: true,
      //   title: Text(
      //     'Comments',
      //     style: pacificoStyle(30),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream: captionCollection
                        .doc(widget.documentid)
                        .collection('comments')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot commentdoc =
                                snapshot.data.documents[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    commentdoc.data()['displaypicture']),
                              ),
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: commentdoc.data()['username'],
                                      style: robotoStyle(
                                          20, Colors.black, FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: commentdoc.data()['comment'],
                                      style: robotoStyle(20, Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(tago
                                      .format(
                                          commentdoc.data()['time'].toDate())
                                      .toString()),
                                ],
                              ),
                            );
                          });
                    }),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: "Add a comment...",
                    hintStyle: robotoStyle(16),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                trailing: OutlineButton(
                  onPressed: () => addComment(),
                  borderSide: BorderSide.none,
                  child: Text(
                    "Add",
                    style: robotoStyle(16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
