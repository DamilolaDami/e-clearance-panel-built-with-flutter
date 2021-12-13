import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference bursary =
      FirebaseFirestore.instance.collection("Bursary");
  CollectionReference registeredStudents =
      FirebaseFirestore.instance.collection("users");
  CollectionReference admins =
      FirebaseFirestore.instance.collection("Admin");
      CollectionReference recentctivities =
      FirebaseFirestore.instance.collection("recentactivies");
  //FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getAdmindetaiils(id) async {
    var result = FirebaseFirestore.instance.collection("Admin").doc(id).get();
    return result;
  }

//slider
  // Future<String> uploadSliderImageToDb(url) async {
  //   String downloadUrl = await storage.ref(url).getDownloadURL();
  //   if (downloadUrl != null) {
  //     firestore.collection("sliders").add({
  //       'image': downloadUrl,
  //     });
  //   }
  //   return downloadUrl;
  // }

  // deleteBannerImageFromDB(id) async {
  //   firestore.collection("sliders").doc(id).delete();
  // }

  // //category
  // Future<String> uploadCategoryImageToDb(url, categoryName) async {
  //   String downloadUrl = await storage.ref(url).getDownloadURL();
  //   if (downloadUrl != null) {
  //     category.doc(categoryName).set({
  //       'image': downloadUrl,
  //       'name': categoryName,
  //     });
  //   }
  //   return downloadUrl;
  // }

  Future<void> confirmDelete({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.lato(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: GoogleFonts.lato(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
               // deleteBannerImageFromDB(id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  //vendor

  clearedStudents({id, cleared}) async {
    registeredStudents.doc(id).update({
      'cleared': cleared,
       
    });
  }
  Future<void>updateCleared({String? title, message, email, date})async{
    User? user = FirebaseAuth.instance.currentUser;
    recentctivities.doc().set({
      'title': 'Cleared Status',
       'message': 'you have been cleared successfully',
       'date': date,
       'email': email,
    });

  }
   Future<void>updateBlocked({String? title, message, email, date})async{
    User? user = FirebaseAuth.instance.currentUser;
    recentctivities.doc().set({
      'title': 'Cleared Status',
       'message': 'you have been blocked',
       'date': date,
       'email': email,
    });

  }
}
