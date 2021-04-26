import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/screens/welcome.dart';
import 'package:fluuter_provider/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluuter_provider/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/modals/user.dart';

void main()  async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoadScreen(),
    },
  ));
}

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      initialData: null,
      value: AuthService().uservalue,
      child: MaterialApp(
        // home: Wrapper(),
        home: Welcome(),
   ),
    );
  }
}
