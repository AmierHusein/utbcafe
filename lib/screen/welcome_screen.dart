import 'package:utb_cafe/screen/login_screen.dart';
import 'package:utb_cafe/screen/signup_screen.dart';
import 'package:utb_cafe/widgets/customized_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/background.jpg"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 130,
              width: 180,
              child: Image(
                  image: AssetImage("images/logo2.png"), fit: BoxFit.cover),
            ),
            const SizedBox(height: 40),
            CustomizedButton(
              buttonText: "Login",
              buttonColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
            CustomizedButton(
              buttonText: "Register",
              buttonColor: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
            ),
            const SizedBox(height: 20),
          //  const Padding(
          //     padding:  EdgeInsets.all(20.0),
          //     child: Text(
          //       "Continue as a Guest",
          //       style: TextStyle(color: Color(0xff35C2C1), fontSize: 15),
          //     ),
          //   )
          ],
        ),
      ),
    );
  }
}