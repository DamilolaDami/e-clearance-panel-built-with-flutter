import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:schoolmanagement/auths/authmodels/sidemenus.dart';
import 'package:schoolmanagement/auths/overviewcards/dashboars.dart';
import 'package:schoolmanagement/auths/overviewcards/services.dart';
import 'package:schoolmanagement/auths/overviewcards/style.dart';
import 'package:schoolmanagement/customtext.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home-screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SideBarWidget _sideBarWidget = SideBarWidget();
   User? user = FirebaseAuth.instance.currentUser;
  FirebaseServices? _firebaseServices;

  @override
  Widget build(BuildContext context) {
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
              Container(
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
        backgroundColor: light,
        sideBar: _sideBarWidget.SideBarMenus(context, HomePage.id),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Visibility(
        //   visible:_firebaseServices!.bursary.where("email",isEqualTo: user!.email).where("stackholder", isEqualTo: 'super-admin').snapshots()!=null,
                    child: OverviewCards()),
              ],
            ),
          ),
        ));
  }
}
