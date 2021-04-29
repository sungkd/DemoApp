import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/home/home.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:fluuter_provider/screens/authenticate.dart';
import 'package:fluuter_provider/screens/welcome.dart';
import 'package:fluuter_provider/services/google_sign_in.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // backgroundColor: Color(0xffFF045C5C),
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final provider = Provider.of<GoogleSignInProvider>(context);

                if(provider.isSignedIn) {
                  return buildLoading();
                }
                else if (snapshot.hasData) {
                  return Authenticate();
                }
                else {
                  return Welcome();
                }
              }
          ),
        ),
    );


  }

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      Center(child: CircularProgressIndicator()),
    ],
  );

    // final getuser = Provider.of<UserData>(context);
    //
    // // Return Home (Home screen) or Authenticate(Register)
    // if (getuser == null) {
    //   return Home();
    //
    // }
    // else
    // {
    //   return Authenticate();
    // }



  }

