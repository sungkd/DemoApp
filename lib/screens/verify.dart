import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/home/home.dart';
import 'package:fluuter_provider/screens/register.dart';
import 'package:fluuter_provider/screens/sign_in.dart';
import 'package:line_icons/line_icons.dart';


class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Verification',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
        leading: IconButton(
          icon: Icon(LineIcons.angleLeft),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignIn()
                )
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
          RichText(
          text: TextSpan(
          text:  'An email has been sent to ${user.email}\n\n'
                 'Please verify to proceed',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              letterSpacing: 1.2,),),),
              SizedBox(height: 20,),
            ],
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          width: 300,
          height: 300,
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Authenticate()));
    }
  }
}