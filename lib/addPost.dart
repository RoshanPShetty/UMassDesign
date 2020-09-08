import 'dart:io';
import 'package:UMassDesign/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File imagePath;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: <Widget>[
          Expanded(
              child: TextField(
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
      ),
    );
  }
}
