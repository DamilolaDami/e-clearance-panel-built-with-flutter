import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:schoolmanagement/auths/authmodels/sidemenus.dart';
import 'package:schoolmanagement/auths/overviewcards/services.dart';
import 'package:schoolmanagement/auths/overviewcards/student_details.dart';
import 'package:schoolmanagement/auths/overviewcards/style.dart';
import 'package:schoolmanagement/customtext.dart';

class Students extends StatefulWidget {
  static const String id = 'students';
  const Students({Key? key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    FirebaseServices _services = FirebaseServices();
    bool cleared = false;

    var data;
    return AdminScaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Visibility(
                  child: CustomText(
                text: 'e-clearance',
                color: lightgrey,
                size: 20,
                fontWeight: FontWeight.bold,
              )),
              Expanded(
                child: Container(),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: dark.withOpacity(.7),
                onPressed: () {},
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: dark.withOpacity(.7),
                    ),
                  ),
                  Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                          width: 12,
                          height: 12,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: light, width: 2))))
                ],
              ),
              Container(
                width: 1,
                height: 22,
                color: lightgrey,
              ),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: light,
                      child: Icon(
                        Icons.person_outline,
                        color: dark,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: dark,
          ),
          backgroundColor: light,
          // iconTheme: IconThemeData(
          //   color: Colors.white,
          // ),
          // title: Text(
          //   'Gobike dashboard'.toUpperCase(),
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.w900,
          //     fontSize: 19,
          //   ),
          // ),
        ),
        sideBar: _sideBar.SideBarMenus(context, Students.id),
        body: StreamBuilder(
          stream: _services.registeredStudents.snapshots(),
          builder: (context, snapshot) {
            data = snapshot.data;
            if (snapshot.hasError) {
              return Text('Something Went Wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  showBottomBorder: true,
                  dataRowHeight: 60,
                  headingRowColor: MaterialStateProperty.all(
                    Colors.grey[200],
                  ),
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('E-mail'),
                    ),
                    DataColumn(
                      label: Text('Phone Number'),
                    ),
                    DataColumn(
                      label: Text('Matric Number'),
                    ),
                    //  DataColumn(
                    //   label: Text('Mobile'),
                    //  ),
                    DataColumn(
                      label: Text('Email'),
                    ),
                     DataColumn(
                      label: Text('Status'),
                    ),
                      DataColumn(
                      label: Text('View Details'),
                    ),
                   
                   
                   

                    DataColumn(
                      label: Text('Clear Student'),
                    ),
                  ],
                  rows: _vendordetails(data, _services, cleared)),
            );
          },
        ));
  }

  List<DataRow> _vendordetails(
      QuerySnapshot snapshot, FirebaseServices services, bool cleared) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(Text(document.data()!['username'])),
        DataCell(Text(document.data()!['email'] ?? '')),
        DataCell(Text(document.data()!['username'])),
        DataCell(Text(document.data()!['Matric Number'])),
        
       
        DataCell(Text(document.data()!['email'])),
         DataCell(
           Container(
             height: 20,
             width: 20,
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               color:document.data()!['cleared'] == true? Colors.green: Colors.grey,
              
             ),
           )
         ),
         DataCell(
           IconButton(onPressed: (){
                   showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StudentDetails(
                    document.data()!['email'] ?? '', 
                  );
                });
           }, icon: Icon(Icons.details))
         ),
        // DataCell(Text(document.data()['email']))

        DataCell(GestureDetector(
            onTap: (){
            
               showDialog(context: context, builder: (context){
                return AlertDialog(
                 title: document.data()!['cleared'] == true? Text("Block"):  Text("Clear"),
                 content: Text("Are you sure? "),
                 actions: [
                   FlatButton(onPressed: (){
                       Navigator.pop(context);
                   }, child: Text("Cancel")),
                    FlatButton(onPressed: (){
                     services.clearedStudents(
                       id: document.data()!['email'],
                       cleared:  document.data()!['cleared'] ? false:true,
                     );
                   document.data()!['cleared']== true?
                     services.updateCleared(
                       email: document.data()!['email'] ,
                       date: DateFormat('yMMMd').format(DateTime.now()),
                     ): 
                      services.updateBlocked(
                           email: document.data()!['email'] ,
                       date: DateFormat('yMMMd').format(DateTime.now()),
                     );
                        Navigator.pop(context);
                   }, child: Text("Confirm"))
                 ],
                );
               });
             },
              
            
           
            child: Container(
              decoration: BoxDecoration(
               
                color: document.data()!['cleared'] ==true?Colors.green:Colors.red,
                borderRadius: BorderRadius.circular(2)
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: CustomText(
                text:document.data()!['cleared'] ==true? "Cleared": "Clear",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      ]);
    }).toList();
    return newList;
  }
}
