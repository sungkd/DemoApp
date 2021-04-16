import 'package:flutter/material.dart';
import 'package:fluuter_provider/services/auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:fluuter_provider/constants/loading.dart';

class Register extends StatefulWidget {


  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  bool loading = false;

  //Store User Name and Password
  String email = '';
  String password = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('User Registration'),
        centerTitle: false,
        backgroundColor: Colors.grey[900],
        actions: [
          TextButton.icon(
              icon: Icon(Icons.person,
                  color: Colors.white),
              label: Text('Sign In',
                style: TextStyle(color: Colors.white),
              ),
            onPressed: () {
                widget.toggleView();
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            //Image(image: AssetImage('assets/dog1.jpg')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                      icon:  Icon(LineIcons.userCircle,color: Colors.white)),
                      validator: (val) => val.isEmpty ? 'Enter email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),

                    SizedBox(height: 20),

                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          icon:  Icon(LineIcons.lock,color: Colors.white)),

                      validator: (val) => val.length < 8 ? 'Password must be 8 characters long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      obscureText: true,
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      child: Text('Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                       if(_formKey.currentState.validate()) {
                         setState( () => loading = true);
                         dynamic result = await _auth.registerUser(email,password);
                         if (result == null) {
                           setState(() {
                             error = 'Please supply valid email';
                             loading = false;
                           });
                         }
                       }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
