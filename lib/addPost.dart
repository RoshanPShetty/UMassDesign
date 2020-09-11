import 'dart:io';
import 'package:UMassDesign/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File imagePath;
  TextEditingController captionController = TextEditingController();
  bool uploading = false;

  pickImage(ImageSource imgsource) async {
    final image = await ImagePicker().getImage(source: imgsource);
    setState(() {
      imagePath = File(image.path);
    });
    Navigator.pop(context);
  }

  optionsDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text(
                  "Camera",
                  style: robotoStyle(20),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text(
                  "Gallery",
                  style: robotoStyle(20),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: robotoStyle(20),
                ),
              ),
            ],
          );
        });
  }

  uploadImage(String id) async {
    StorageUploadTask storageUploadTask =
        await photos.child(id).putFile(imagePath);
    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  postPhoto() async {
    uploading = true;
    var captiondocuments = await captionCollection.get();
    int length = captiondocuments.docs.length;
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userdocuments =
        await userCollection.doc(firebaseuser.uid).get();

    // 2 Conditions:
    // A. Only Image is posted
    if (captionController.text == '' && imagePath != null) {
      String imageUrl = await uploadImage('Caption $length');

      captionCollection.doc('Caption $length').set({
        'username': userdocuments.data()['username'],
        'displaypicture': userdocuments.data()['displaypicture'],
        'uid': firebaseuser.uid,
        'id': 'Caption $length',
        'image': imageUrl,
        'likes': [],
        'commentcount': 0,
        'shares': 0,
        'type': 1
      });
      Navigator.pop(context);
    }

    // B. Both the Image and Caption is posted
    if (captionController.text != '' && imagePath != null) {
      String imageUrl = await uploadImage('Caption $length');

      captionCollection.doc('Caption $length').set({
        'username': userdocuments.data()['username'],
        'displaypicture': userdocuments.data()['displaypicture'],
        'uid': firebaseuser.uid,
        'id': 'Caption $length',
        'image': imageUrl,
        'caption': captionController.text,
        'likes': [],
        'commentcount': 0,
        'shares': 0,
        'type': 2
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[700],
        onPressed: () => postPhoto(),
        child: Icon(Icons.publish),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
        title: Text('Add Post',
            style: robotoStyle(
              20,
            )),
        actions: <Widget>[
          InkWell(
              onTap: () => optionsDialog(),
              child: Icon(Icons.add_photo_alternate))
        ],
      ),
      body: uploading == false
          ? Column(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: captionController,
                  maxLines: null,
                  style: robotoStyle(20),
                  decoration: InputDecoration(
                      labelText: "What's happening now?",
                      labelStyle: robotoStyle(25),
                      border: InputBorder.none),
                )),
                imagePath == null
                    ? Container()
                    : MediaQuery.of(context).viewInsets.bottom > 0
                        ? Container()
                        : Image(
                            width: 200,
                            height: 200,
                            image: FileImage(imagePath),
                          )
              ],
            )
          : Center(
              child: Text(
                'Uploading...',
                style: robotoStyle(20),
              ),
            ),
    );
  }
}
