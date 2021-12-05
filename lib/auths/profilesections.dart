import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:schoolmanagement/auths/authmodels/sidemenus.dart';

class ProfileSection extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileSection({ Key? key }) : super(key: key);

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      sideBar: _sideBar.SideBarMenus(context, ProfileSection.routeName),
      body: Center(
        child: Text('Profile'),
      ),
      
    );
  }
}