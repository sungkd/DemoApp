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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }


  double _containerWidth = 380;
  double _containerHeight = 440;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return loading ? Loading() : Scaffold(
      backgroundColor: Color(0xffFF045C5C),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Hooman Registration',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 18.0,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFF045C5C),
        elevation: 50.0,
        brightness: Brightness.dark,
        leading: IconButton(
            icon: Icon(LineIcons.angleLeft),
            onPressed: () {
              widget.toggleView();
            }),
      ),
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
                          style: TextStyle(color: Colors.black87),
                          controller: emailController,
                          decoration: richTextDecoration.copyWith(
                              labelText: 'Enter Email',
                              prefixIcon: Icon(LineIcons.envelopeAlt),
                              suffixIcon: emailController.text.isEmpty ? Container(width: 0)
                                 : IconButton(
                                 icon: Icon(Icons.close),
                                 onPressed: () {
                                   emailController.clear();
                                 } )
                          ),
                          validator: (val) => val.isEmpty ? 'Enter email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20,),
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
                        SizedBox(height: 10,),
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
                          child: Text('Register',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          style: textButtonStyle,
                          onPressed: () async {
                            if(_formKey.currentState.validate()) {
                              setState( () => loading = true);

                              dynamic result = await _auth.registerUser(email,password);

                              if(result == null) {
                                setState(() {
                                  error = 'Error - try again';
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
                                text: 'Already have an account?',
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
                              child: Text('Login'),
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
                //     image: AssetImage('assets/catsleep1.jpg',),
                //     fit: BoxFit.cover,
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

// await _auth.registerUser(email, password).then((_) {
//   Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => VerifyScreen()
//       )
//   );
// });