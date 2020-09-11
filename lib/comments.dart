import 'package:UMassDesign/utils/variables.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final String documentid;
  Comments(this.documentid);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        centerTitle: true,
        title: Text(
          'Comments',
          style: pacificoStyle(30),
        ),
      ),
      body: StreamBuilder(
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
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {});
          }),
    );
  }
}
