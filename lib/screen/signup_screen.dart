import 'package:firebase_auth/firebase_auth.dart';
import 'package:utb_cafe/authorize/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/customized_button.dart';
import '../widgets/customized_textfield.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var options = [
    'Customer',
    'Vendor',
  ];
  
  var _currentItemSelected = "Customer";
  var role = "Customer";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Sign up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              CustomizedTextfield(
                myController: _usernameController,
                hintText: "Username",
                isPassword: false,
              ),
              CustomizedTextfield(
                myController: _emailController,
                hintText: "Email",
                isPassword: false,
              ),
              CustomizedTextfield(
                myController: _passwordController,
                hintText: "Password",
                isPassword: true,
              ),
              CustomizedTextfield(
                myController: _confirmPasswordController,
                hintText: "Confirm Password",
                isPassword: true,
              ),
              Container(
                margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
                width: double.infinity,
                height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffE8ECF4),
                  border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          
                            ),
                          borderRadius: BorderRadius.circular(10)
                           ),
                child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Text(
                            //   "Sign up as: ",
                            //   textAlign: TextAlign.left,
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.grey,
                            //     ),
                            //   ),
                            DropdownButton<String>(
                              dropdownColor: Colors.blue[900],
                              isDense: true,
                              isExpanded: true,
                              iconEnabledColor: Colors.grey,
                              focusColor: Colors.grey,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  role = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                        ),
                      ),
                        const SizedBox(
                          height: 30,
                        ),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.black,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    await signup(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        role);

                    if (!mounted) return;

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                  } on FirebaseException catch (e) {
                    debugPrint(e.message);
                  }

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
              ),
              
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 1,
              //         width: MediaQuery.of(context).size.height * 0.15,
              //         color: Colors.grey,
              //       ),
              //       const Text("Or Register with"),
              //       Container(
              //         height: 1,
              //         width: MediaQuery.of(context).size.height * 0.16,
              //         color: Colors.grey,
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //           height: 50,
              //           width: 100,
              //           decoration: BoxDecoration(
              //             border: Border.all(color: Colors.black, width: 1),
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: IconButton(
              //             icon: const Icon(
              //               FontAwesomeIcons.facebookF,
              //               color: Colors.blue,
              //             ),
              //             onPressed: () {},
              //           )),
              //       Container(
              //         height: 50,
              //         width: 100,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.black, width: 1),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: IconButton(
              //           icon: const Icon(
              //             FontAwesomeIcons.google,
              //             // color: Colors.blue,
              //           ),
              //           onPressed: () {},
              //         ),
              //       ),
              //       Container(
              //           height: 50,
              //           width: 100,
              //           decoration: BoxDecoration(
              //             border: Border.all(color: Colors.black, width: 1),
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: IconButton(
              //             icon: const Icon(
              //               FontAwesomeIcons.apple,
              //               // color: Colors.blue,
              //             ),
              //             onPressed: () {},
              //           ))
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 8, 8, 8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(
                          color: Color(0xff1E232C),
                          fontSize: 15,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      },
                      child: const Text("  Login Now",
                          style: TextStyle(
                            color: Color(0xff35C2C1),
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
    Future signup(String email, String password, String role) async {
      const CircularProgressIndicator(); {
        await _auth.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) => {postDetailsToFirestore(email, role)})
    .catchError((e) {});
      }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('Users');
    ref.doc(user!.uid).set({'email': _emailController.text, 'role': role});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}

