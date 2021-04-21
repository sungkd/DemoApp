import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/services/auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:fluuter_provider/constants/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;



  //Store User Name and Password
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return loading ? Loading() : Scaffold(
      //backgroundColor: Color(0xff5F574C),
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: false,
        backgroundColor: Color(0xff645C51),
        actions: [
          TextButton.icon(
              icon: Icon(LineIcons.cat,
              color: Colors.white),
              label: Text('Register',
              style: TextStyle(color: Colors.white),
              ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Image(image: AssetImage('assets/cat.jpg'),
                  fit: BoxFit.fill,
                  height: screenHeight - 110 ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0,180,40,0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: textInputDecoration.copyWith(hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                        icon:  Icon(LineIcons.userCircle, color: Colors.white,)),
                        validator: (val) => val.isEmpty ? 'Enter email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),

                      SizedBox(height: 20),

                      TextFormField(
                        style: TextStyle(color: Colors.white),
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
                          child: Text('Sign In',
                          style: TextStyle(color: Colors.white),
                          ),
                        onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          setState( () => loading = true);

                          dynamic result = await _auth.sigInUser(email,password);
                          if (result == null) {
                            setState(() {
                              error = 'Invalid email or password';
                              loading = false; });
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
      ),
    );
  }
}
