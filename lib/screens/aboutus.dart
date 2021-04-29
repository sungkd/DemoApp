import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AboutUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    String _line1 = 'Whenever we want to adopt a pet of put a pet for adoption '
        'we need to depend on pages or groups on social media with '
        'higher reach and sometimes your message might be not be '
        'acknowledged due to number of messages in their inbox. ';

    String _line2 = 'The idea behind creating this application is to have a '
        'dedicated platform for pet adoption where anyone can request '
        'for adoption and third party dependency will be reduced. ';

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'About Us',
            style: TextStyle(
              fontSize: 15.0
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(LineIcons.angleLeft,
          color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Container(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: _line1,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              RichText(
                text: TextSpan(
                  text: _line2,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      letterSpacing: 1.2
                  ),
                ),
              ),
            ],
          ),
         margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        ),

    );
  }
}
