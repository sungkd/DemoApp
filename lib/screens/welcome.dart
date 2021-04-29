import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/constants/homebackground.dart';
import 'package:fluuter_provider/modals/google_button.dart';


class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    double _containerWidth = 380;
    double _containerHeight = 600;


    String _line1 = 'Get information of all the little furry pets'
        ' in India who are looking for a home.';

    String _line2 = 'Get the information of all the little furry pets'
        ' in India who are looking for a home.';

      return Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter(),),
          buildSignUp(_line1),
        ],
      );
      // return Scaffold(
      //   backgroundColor: Color(0xffFF045C5C),
      //   body: SafeArea(
      //     child: Center(
      //       child: Container(
      //         child: Column(
      //           children: [
      //             RichText(
      //                 text: TextSpan(
      //                   text: 'Welcome to',
      //                   style: TextStyle(
      //                     fontSize: 20.0,
      //                     color: Colors.black87,
      //                     letterSpacing: 1.0,
      //                   ),
      //                 )),
      //             RichText(
      //                 text: TextSpan(
      //                   text: 'Pet Adopt',
      //                   style: TextStyle(
      //                     fontSize: 38.0,
      //                     color: Colors.black87,
      //                     letterSpacing: 1.0,
      //                   ),
      //                 )),
      //             SizedBox(height: 50,),
      //             RichText(
      //                 textAlign: TextAlign.center,
      //                 text: TextSpan(
      //                   text: _line1,
      //                   style: TextStyle(
      //                     fontSize: 18.0,
      //                     color: Colors.black87,
      //                     letterSpacing: 1.0,
      //                   ),
      //                 )),
      //             SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
      //             GoogleSignInButton(),
      //             Image.asset('assets/kitty.png',
      //               width: 200,
      //               height: 200,),
      //           ],
      //         ),
      //         decoration: BoxDecoration(
      //             shape: BoxShape.rectangle,
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(10)
      //         ),
      //         width: _containerWidth,
      //         height: _containerHeight,
      //         margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //         padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
      //       ),
      //     ),
      //   ),
      // );


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
                    text: 'Pet Adopt',
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
