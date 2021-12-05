import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/auths/overviewcards/services.dart';

class StudentDetails extends StatefulWidget {
  final String studentId;
   StudentDetails( this.studentId);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();

    return FutureBuilder(
      future: services.registeredStudents.doc(widget.studentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
           
            if(snapshot.hasError) {
              return Center(
                child: Text("Oops something went wrong"),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            
             var parsedDate = DateTime.parse(snapshot.data!['dob'],);
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Details of ${snapshot.data!['username']}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      
                      ),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      )
                    ],
                  ),
                  Divider(),
                  Row(children: [
                    Text('Name: ',),
                    Text(snapshot.data!['username'],)
                  ],),
                  SizedBox(height: 10,),
                    Row(children: [
                    Text('E-mail: ',),
                    Text(snapshot.data!['email'],)
                  ],),
                  SizedBox(height: 10,),
                  
                     Row(children: [
                    Text('Date of birth: ',),
                    Text(parsedDate.toString(),)
                  ],),
                  SizedBox(height: 10,),
                    Row(children: [
                    Text('State of Origin: ',),
                   Container(
                         height:  MediaQuery.of(context).size.height/2,
                         width: MediaQuery.of(context).size.width/2,
                  
                          child: Image.network(snapshot.data!['state of origin']))
                  ],),
                  SizedBox(height:10),
                   Row(children: [
                    Text('Waec ceartificate: ',),
                   Container(
                         height:  MediaQuery.of(context).size.height/2,
                         width: MediaQuery.of(context).size.width/2,
                  
                          child: Image.network(snapshot.data!['waec ceartificate']))
                  ],),
                  
                  
                ],),
              ),
            ),
          ),
        );
      },
    );
  }
}
