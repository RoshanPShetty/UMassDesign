import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

robotoStyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.roboto(fontSize: size, fontWeight: fw, color: color);
}

pacificoStyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.pacifico(fontSize: size, fontWeight: fw, color: color);
}

CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
CollectionReference captionCollection =
    FirebaseFirestore.instance.collection('caption');
CollectionReference leaderboardCollection =
    FirebaseFirestore.instance.collection('liketotal');
StorageReference photos = FirebaseStorage.instance.ref().child('photos');
var sampleProfile =
    'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png';
