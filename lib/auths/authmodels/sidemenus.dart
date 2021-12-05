import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/auths/homepage.dart';
import 'package:schoolmanagement/auths/profilesections.dart';
import 'package:schoolmanagement/auths/stakeholders.dart';
import 'package:schoolmanagement/auths/students.dart';
class SideBarWidget{
  SideBarMenus(context, selectedRoute){
   return SideBar(
        activeBackgroundColor: CupertinoColors.systemBlue,
        activeIconColor: Colors.white,
        iconColor: CupertinoColors.systemBlue,
        textStyle: GoogleFonts.poppins(
          color: Colors.grey[700],
          fontSize: 13,
        ),
        activeTextStyle: TextStyle(
          color: Colors.white,
        ),
        // backgroundColor: Colors.black54,
        items: [
          MenuItem(
            title: 'Dashboard',
            route: HomePage.id,
            icon: Icons.dashboard,
          ),
            MenuItem(
            title: 'StakeHolders',
            route: StakeHolders.tag,
            icon: Icons.height_outlined,
          ),
            MenuItem(
            title: 'Profile Section',
            route: ProfileSection.routeName,
            icon: Icons.person_outlined,
          ),
            MenuItem(
            title: 'Students',
            route: Students.id,
            icon: Icons.person_outlined,
          ),
         
         
         
        ],
        selectedRoute: selectedRoute,
        onSelected: (item) {
          Navigator.of(context).pushNamed(item.route!);
        },
       
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black26,
          child: Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ); 
  }
}