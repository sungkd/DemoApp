import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/services/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>  Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.red[800],
      borderRadius: BorderRadius.circular(10),
    ),
    child: OutlinedButton.icon(
        label: RichText(
          text: TextSpan(
            text: 'Sign In with Google',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      icon: Icon(LineIcons.googlePlus,
      color: Colors.white,),
      onPressed:  () {
          final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login();
      },
    ),
  );

}
