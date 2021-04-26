import 'package:flutter/material.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:fluuter_provider/home/home.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:fluuter_provider/screens/register.dart';
import 'package:fluuter_provider/screens/sign_in.dart';
import 'package:fluuter_provider/screens/wrapper.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final getuser = Provider.of<UserData>(context);

    double _containerWidth = 380;
    double _containerHeight = 600;


    String _line1 = 'Get the information of all the little furry pets'
                    ' in India who are looking for a home.';

    String _line2 = 'Get the information of all the little furry pets'
                    ' in India who are looking for a home.';

    if (getuser == null) {
      return Scaffold(
        backgroundColor: Color(0xffFF045C5C),
        body: SafeArea(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(
                        text: 'Welcome to',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          letterSpacing: 1.0,
                        ),
                      )),
                  RichText(
                      text: TextSpan(
                        text: 'Pet Adopt',
                        style: TextStyle(
                          fontSize: 38.0,
                          color: Colors.black87,
                          letterSpacing: 1.0,
                        ),
                      )),
                  SizedBox(height: 50,),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: _line1,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black87,
                          letterSpacing: 1.0,
                        ),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
                  TextButton(
                    child: Text('Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),),
                    style: textButtonStyle,
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Wrapper(),
                      )
                      );
                    },
                  ),
                  Image.asset('assets/kitty.png',
                    width: 200,
                    height: 200,),


                ],
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              width: _containerWidth,
              height: _containerHeight,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            ),
          ),
        ),
      );
    }
    else
    {
      return Authenticate();

    }

  }
}
