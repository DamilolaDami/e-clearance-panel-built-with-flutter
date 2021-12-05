import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:schoolmanagement/auths/authmodels/sidemenus.dart';
import 'package:schoolmanagement/auths/overviewcards/style.dart';
import 'package:schoolmanagement/customtext.dart';
import 'package:schoolmanagement/module/extension.dart';

class StakeHolders extends StatefulWidget {
  static String tag = 'stakeholders';
  const StakeHolders({Key? key}) : super(key: key);

  @override
  _StakeHoldersState createState() => _StakeHoldersState();
}

class _StakeHoldersState extends State<StakeHolders> {
  var options = ["Option 1", "Option 2", "Option 3"];
  final SideBarWidget _sideBar = SideBarWidget();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final password = TextEditingController();

  List<String> _gender = ['Male', 'Female'];
  List<String> _stackholders = [
    'Bursary',
    'Registry',
    'Exam Office',
  ];
  String? selectedStackHolders;
  String? code;
  String? selectedGender;
  final _formKey = GlobalKey<FormBuilderState>();
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
        sideBar: _sideBar.SideBarMenus(context, StakeHolders.tag),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Stakeholder",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _firstname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter firstname';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).margin9,
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _lastname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter lastname';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).margin9,
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.mail_outline_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).margin9,
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    controller: _phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).margin9,
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ).margin9,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ButtonTheme(
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          hint: Text('Select Gender'),
                          value: selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGender = newValue.toString();
                            });
                          },
                          items: _gender.map((gender) {
                            return DropdownMenuItem(
                              child: new Text(gender),
                              value: gender,
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null)
                              return "Please select your gender";
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ButtonTheme(
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          hint: Text('Select Stakeholder'),
                          value: selectedStackHolders,
                          onChanged: (newValue) {
                            setState(() {
                              selectedStackHolders = newValue.toString();
                            });
                          },
                          items: _stackholders.map((stackHolder) {
                            return DropdownMenuItem(
                              child: new Text(stackHolder),
                              value: stackHolder,
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null)
                              return "Please select your gender";
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ButtonTheme(
                  child: RaisedButton(
                    color: blue,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Loading...'),
                            );
                          });
                      registStakeHolder(
                        email: _email.text,
                        password: password.text,
                        error: code,
                      ).then((value) => {
                            if (value != null)
                              {
                                saveStackHolder(
                                  email: _email.text,
                                  first: _firstname.text,
                                  gender: selectedGender,
                                  last: _lastname.text,
                                  mobile: _phone.text,
                                  stackholder: selectedStackHolders,
                                ),
                                Navigator.pop(context),
                              }
                          });
                    },
                    child: Text(
                      'Add Stakeholder',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<User?> registStakeHolder({email, password, error}) async {
    email = email;
    User? user;

    UserCredential userCrendential;
    try {
      userCrendential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCrendential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = "The account already exists for that email.";
        error = e.code;
      }
    } catch (e) {
      // error = e.code;

      print(e);
    }
    return user;
  }

  Future<void> saveStackHolder(
      {String? first,
      String? last,
      String? email,
      String? mobile,
      String? gender,
      String? stackholder}) async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference saveStackHolder =
        FirebaseFirestore.instance.collection('Bursary').doc(user!.email);
    saveStackHolder.set({
      "first": first,
      "last": last,
      "email": email,
      "phone number": mobile,
      "gender": gender,
      "stackholder": stackholder,
    });
    return null;
  }
}
