import 'package:flutter/material.dart';
import 'package:fluuter_provider/constants/homebackground.dart';
import 'package:fluuter_provider/modals/google_button.dart';


class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    String _line1 = 'Get information of all the little furry pets'
        ' in India who are looking for a home.';


      return Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter(),),
          buildSignUp(_line1),
        ],
      );

  }

  Widget buildSignUp(String _line1) => Column(
    children: [
      Spacer(),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: 50),
          width: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                  text: TextSpan(
                    text: 'Welcome to',
                    style: TextStyle(fontSize: 20.0, color: Colors.white,
                      letterSpacing: 1.0,),),
              ),
              RichText(
                  text: TextSpan(
                    text: 'Adotta Pets',
                    style: TextStyle(fontSize: 38.0, color: Colors.white,
                      letterSpacing: 1.0,),),
              ),
            ],
          ),
        ),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(right: 25,left: 25),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: _line1,
              style: TextStyle(fontSize: 20.0, color: Colors.black87,
                letterSpacing: 1.0,),
            ),
        ),
      ),
      SizedBox(height: 30,),
      GoogleSignInButton(),
      SizedBox(height: 12),
      Text(
        'Login to continue',
        style: TextStyle(fontSize: 16),
      ),
      Spacer(),
    ],
  );
}
