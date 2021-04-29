import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/services/auth.dart';
import 'package:fluuter_provider/constants/decorate.dart';
import 'package:fluuter_provider/constants/loading.dart';
import 'package:line_icons/line_icons.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey  = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool isHidden = false;

  //Store User Name and Password
  String email = '';
  String password = '';
  String error = '';
  String _passwordresetemail = '';


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }


  double _containerWidth = 380;
  double _containerHeight = 500;


  @override
  Widget build(BuildContext context) {


    return loading ? Loading() : Scaffold(
      // backgroundColor: Color(0xff4ec2c2),
      backgroundColor: Color(0xffFF045C5C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Email',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Colors.black87),
                          decoration: richTextDecoration.copyWith(
                              labelText: 'Enter Email',
                              prefixIcon: Icon(LineIcons.envelopeAlt),
                              suffixIcon: emailController.text.isEmpty ? Container(width: 0)
                                  : IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    emailController.clear(); }
                                  )
                                  ), //richTextDecoration.copyWith
                          validator: (val) => val.isEmpty ? 'Enter email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: 'Password',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                 enableDrag: true,
                                  isScrollControlled: true,
                                  context: context, builder: (context) {
                                    return Container(
                                      height: 400,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Password Reset',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20.0,
                                                  wordSpacing: 1.0,
                                                  letterSpacing: 1.5,),
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Form(
                                            key: _formKey1,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  maxLines: 1,
                                                  controller: emailController,
                                                  style: TextStyle(color: Colors.black87),
                                                  decoration: richTextDecoration.copyWith(
                                                      labelText: 'Enter Email to reset password',
                                                      prefixIcon: Icon(LineIcons.envelopeAlt),
                                                  ), //richTextDecoration.copyWith
                                                  validator: (val) => val.isEmpty ? 'Enter email' : null,
                                                  onChanged: (val) {
                                                    setState(() =>
                                                    _passwordresetemail = val);
                                                  },
                                                ),
                                                SizedBox(height: 15,),
                                                TextButton(
                                                  child: Text('Reset',
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),),
                                                    style: textButtonStyle,
                                                    onPressed: () async {
                                                      if(_formKey1.currentState.validate()) {

                                                        _auth.resetPassword(_passwordresetemail);

                                                        setState(() {
                                                          email = '';
                                                          password = '';

                                                        });
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);

                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content:
                                                            Text('Password Reset link sent to - $_passwordresetemail'),
                                                            backgroundColor: Colors.blueAccent,
                                                            duration: Duration(seconds: 5),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize:Size(5,5)),
                              child: Text('Forgot Password?'),
                            )
                          ],
                        ),
                        TextFormField(
                          obscureText: isHidden,
                          style: TextStyle(color: Colors.black87),
                          decoration: richTextDecoration.copyWith(
                              labelText: 'Password',
                              prefixIcon: Icon(LineIcons.lock),
                              suffixIcon: IconButton(
                                  icon: isHidden ? Icon(LineIcons.eyeSlashAlt)
                                  : Icon(LineIcons.eyeAlt),
                                  onPressed: togglePasswordVisibility
                                  )
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (val) => val.length < 8 ? 'Password must be 8 characters long' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 25,),
                        TextButton(
                          child: Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          style: textButtonStyle,
                          onPressed: () async {
                            if(_formKey.currentState.validate()) {
                              setState( () => loading = true);

                              dynamic result = await _auth.sigInUser(email,password);

                              if(result == null) {
                                  setState(() {
                                    error = 'Invalid email or password';
                                    loading = false;
                                  }
                                );
                               }
                              else {
                                error = '';
                              }
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(color: Colors.black,
                                  fontSize: 15,
                                )
                            ),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize:Size(5,5)),
                              child: Text('Sign Up'),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            '$error',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: _containerWidth,
                  height: _containerHeight,
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                ),
                // SizedBox(height: 20),
                // Center(
                //   child: Image(
                //     image: AssetImage('assets/catwindow.png',),
                //     fit: BoxFit.fill,
                //     width: 200,
                //     height: 200,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

}
