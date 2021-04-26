import 'package:flutter/material.dart';
import 'package:fluuter_provider/home/home.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:fluuter_provider/screens/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final getuser = Provider.of<UserData>(context);

    // Return Home (Home screen) or Authenticate(Register)
    if (getuser == null) {
      return Home();

    }
    else
    {
      return Authenticate();
    }



  }
}
