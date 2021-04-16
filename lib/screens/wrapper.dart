import 'package:flutter/material.dart';
import 'package:fluuter_provider/home/home.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:fluuter_provider/screens/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final getuser = Provider.of<UserData>(context);

    print(getuser);

    // Return Home (Home screen) or Authenticate(Register)
    if (getuser == null) {
      print('null');
      return Home();

    }
    else
      {
        print('not null');
        return Authenticate();
      }


  }
}
