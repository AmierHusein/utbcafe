import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:utb_cafe/screen/login_screen.dart';
import '../screen/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Function postDetailsToFirestore;

  Future login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Future signup(String email, String password, String role) async {
  //   await _auth.createUserWithEmailAndPassword(email: email, password: password)
  //   .then((value) => {postDetailsToFirestore(email, role)});
  //     }
      
  //       postDetailsToFirestore(String email, String role) {
  //         FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   var user = _auth.currentUser;
  //   CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  //   ref.doc(user!.uid).set({'email': _emailController.text, 'role': role});
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  // }
        
  

  //  Future logininwithgoogle() async {
  //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  //   AuthCredential myCredential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   UserCredential user =
  //       await FirebaseAuth.instance.signInWithCredential(myCredential);

  //   debugPrint(user.user?.displayName);
  // }
} 
