import 'package:flutter/material.dart';
import 'package:schoolmanagement/auths/homepage.dart';
import 'package:schoolmanagement/auths/profilesections.dart';
import 'package:schoolmanagement/auths/stakeholders.dart';
import 'package:schoolmanagement/auths/students.dart';
import 'auths/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
       routes: {
      
        HomePage.id:(_)=> HomePage(),
        StakeHolders.tag:(_)=> StakeHolders(),
        ProfileSection.routeName:(_)=> ProfileSection(),
        Students.id:(_)=> Students(),
      },
    );
  }
}

