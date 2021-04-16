import 'package:flutter/material.dart';
import 'package:fluuter_provider/screens/register.dart';
import 'package:fluuter_provider/screens/sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showSignIn = true;

  void toggleView() {
    setState( () => showSignIn = !showSignIn);
  }


  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return SignIn(toggleView:toggleView);
    }
    else
    {
      return Register(toggleView:toggleView);
    }
  }
}
