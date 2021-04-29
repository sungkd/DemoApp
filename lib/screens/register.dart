import 'package:email_auth/email_auth.dart';
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
  String confirmpassword = '';
  String name = '';
  String error = '';
  int otp = 0;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  bool submitValid = false;
  bool isHidden = false;
  bool _isInvalid = false;
  bool _otpMatches = false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmpasswordController.dispose();


    super.dispose();
  }

  ///a void funtion to send the OTP to the user
  void sendOtp() async {
    EmailAuth.sessionName = "Company Name";
    bool result =
    await EmailAuth.sendOtp(receiverMail: emailController.value.text);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
    else {
      setState(() {
        submitValid = true;
      });
    }
  }


  ///a void function to verify if the Data provided is true
  void verify() {
    bool verify = EmailAuth.validate(receiverMail: emailController.value.text,
                  userOTP: otpController.value.text);

    if(verify) {
      setState(() {
        _otpMatches = true;
      });
    }
    else
      {
        setState(() {
          _otpMatches = false;
        });
      }
  }


  double _containerWidth = 380;


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double _containerHeight = MediaQuery.of(context).size.height;

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
        // backgroundColor: Color(0xffFF045C5C),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.dark,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              widget.toggleView();
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Email
                        Row(
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
                            Spacer(),

                            //OTP Trigger
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize:Size(5,5)),
                              child: RichText(
                                text: TextSpan(
                                  text:'Request OTP',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // sendOtp();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("OTP sent to",
                                        style: TextStyle(
                                          color: Colors.blueAccent
                                        ),
                                        ),
                                        content: Text(email,
                                         style: TextStyle(
                                           color: Colors.blueAccent
                                         ),),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Ok"),
                                          ),
                                        ],
                                        backgroundColor: Colors.black87
                                        ,
                                      );
                                    });
                                print('sent otp - $submitValid');
                              },
                            ),
                          ],
                        ),
                        // SizedBox(height: 10,),
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

                        //OTP
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'OTP',
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
                              labelText: 'Enter OTP',
                              prefixIcon: Icon(LineIcons.lock),
                              suffixIcon: IconButton(
                                  icon: isHidden ? Icon(LineIcons.eyeSlashAlt)
                                      : Icon(LineIcons.eyeAlt),
                                  onPressed: togglePasswordVisibility
                              )
                          ),
                          keyboardType: TextInputType.number,
                          controller: otpController,
                          onChanged: (val) {
                            setState(() => otp = int.parse(val) );
                          },
                        ),

                        SizedBox(height: 15,),
                        //Password
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

                        SizedBox(height: 15,),
                        //Confirm Password
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Confirm Password',
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
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(LineIcons.lock),
                              suffixIcon: IconButton(
                                  icon: isHidden ? Icon(LineIcons.eyeSlashAlt)
                                      : Icon(LineIcons.eyeAlt),
                                  onPressed: togglePasswordVisibility
                              )
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller: confirmpasswordController,
                          validator: (val) => val.length < 8 ? 'Password must be 8 characters long' : null,
                          onChanged: (val) {
                            setState(() => confirmpassword = val);
                          },
                        ),

                        //Register Button
                        SizedBox(height: 25,),
                        TextButton(
                          child: Text('Register',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          style: textButtonStyle,
                          onPressed: () async {

                            // verify();

                            print('verfiy - $_otpMatches');
                            if(_formKey.currentState.validate()  )
                            {
                              verify();
                              if(_otpMatches) {

                                if (password == confirmpassword) {
                                  print('all trye');
                                }
                                else
                                  {
                                    print('password dont match');
                                    loading = false;
                                  }
                              }
                              else
                                {
                                  print('invalid otp - $_otpMatches  $otp');
                                  loading = false;
                                }
                              // setState( () => loading = true);
                              //
                              // //Registration
                              // dynamic result = await _auth.registerUser(email,password);
                              //
                              // if(result == null) {
                              //   setState(() {
                              //     error = 'Error - try again';
                              //     loading = false;
                              //   }
                              //   );
                              // }
                            }
                            // else
                            //   {
                            //     if(_otpMatches == false) {
                            //       print('invalid otp');
                            //       loading = false;
                            //     }
                            //     else {
                            //       if(password != confirmpassword) {
                            //         print('password dont match');
                            //         loading = false;
                            //       }
                            //     }
                            //     error = 'Error while registration';
                            //     loading = false;
                            //   }
                          },
                        ),

                        //Already have an account
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
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  // Future <bool> validateUsername(String name) async {
  //   final result = await FirebaseFirestore.instance.collection('Users')
  //                  .where('userName', isEqualTo: name)
  //                  .get();
  //
  //   return result.docs.isEmpty;
  // }
}

// await _auth.registerUser(email, password).then((_) {
//   Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => VerifyScreen()
//       )
//   );
// });