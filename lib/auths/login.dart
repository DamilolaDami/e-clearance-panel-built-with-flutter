import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolmanagement/auths/homepage.dart';
import 'auth.dart';
import '../module/extension.dart';
import '../widgets/main_widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // User user =  firebaseAuth.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Admins");
  Future<void> addAdmin(String? username, String? password) async {
    //creates a new doc with unique doc ID
    return await collectionRef
        .add({
          'Name': username,
          "Password": password,
          //"userid": user?.uid,
        })
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  // printDocID() async {
  //   var querySnapshots = await collectionRef.get();
  //   for (var snapshot in querySnapshots.docs) {
  //     var documentID = snapshot.id;
  //     debugPrint(documentID);
  //   }
  // }
  String? errorCOde;
  String? uid;
  String? userEmail;
  Future<User?> registerWithEmailPassword(String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorCOde = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorCOde = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorCOde = 'The email address is badly formatted.';
      } else if (e.code == 'operation-not-allowed') {
        errorCOde = 'Password sign-in is disabled for this project.';
      } else if (e.code == 'user-disabled') {
        errorCOde = 'The user account has been disabled by an administrator.';
      } else if (e.code == 'user-not-found') {
        errorCOde =
            'There is no user record corresponding to this identifier. The user may have been deleted.';
      } else if (e.code == 'wrong-password') {
        errorCOde =
            'The password is invalid or the user does not have a password.';
      } else {
        errorCOde = 'An undefined error occurred.';
      }
    } on Exception catch (e) {
      errorCOde = e.toString();
    }

    return user;
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        //  await prefs.setBool('auth', true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorCOde = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorCOde = 'Wrong password provided.';
      } else if (e.code == 'email-already-in-use') {
        errorCOde = 'Email already in use.';
      } else if (e.code == 'invalid-email') {
        errorCOde = 'Invalid email.';
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    TextEditingController emailController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    TextEditingController passwordController = TextEditingController();

    // ignore: prefer_const_constructors
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: context.width * 0.3 < 250 ? 250 : context.width * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Clearance  system'
                  .toLabel(bold: true, color: Colors.grey, fontSize: 20),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ).padding9,
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ).padding9,
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Button(
                    title: 'Login',
                    icon: const Icon(Icons.arrow_forward),
                    padding: const EdgeInsets.all(22),
                    color: Colors.green,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        signInWithEmailPassword(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(errorCOde!),
                                    actions: [
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        });
                      }
                    },
                  ).margin9,
                  Button(
                      title: 'Register',
                      icon: const Icon(Icons.edit),
                      padding: const EdgeInsets.all(22),
                      color: Colors.cyan,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          registerWithEmailPassword(
                                  emailController.text, passwordController.text)
                              .then((value) => {
                                    AddAMin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      first: null,
                                      gender: null,
                                      last: null,
                                      mobile: null,
                                      stackholder: "super-admin",
                                    ),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()))
                                  });
                        }
                      }).margin9,
                ],
              ),
            ],
          ),
        ).padding9.card.center,
      ),
    );
  }

  Future<void> AddAMin(
      {String? first,
      String? last,
      String? email,
      String? mobile,
      String? password,
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
      'password': password,
    });
    return null;
  }
}
