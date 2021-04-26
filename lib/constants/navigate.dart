import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_provider/modals/user.dart';
import 'package:fluuter_provider/screens/upload_form.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/home/home.dart';
import 'package:fluuter_provider/screens/aboutus.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {

  final AuthService _auth = AuthService();
  final _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 30);


  _sendEmail() async {
    const url = 'mailto:sungkd123@outlook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    final getuser = Provider.of<UserData>(context);

    return SafeArea(
      child: Drawer(
        child: Material(
          color: Colors.teal[700],
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: _padding,
              children: [
                 buildHeader(
                  name: getuser.email,
                ),
                const SizedBox(height: 20,),
                buildMenuItems(
                  text: 'Home',
                  icon: LineIcons.home,
                  onClicked: () => selectedItem(context,0),
                ),

                buildMenuItems(
                  text: 'Upload Form',
                  icon:  LineIcons.alternateCloudUpload,
                  onClicked: () => selectedItem(context,1),
                ),

                buildMenuItems(
                  text: 'Vets Info',
                  icon:  LineIcons.hospitalSymbol,
                  onClicked: () async {
                    AndroidIntent intent = AndroidIntent(
                        action: "action_view",
                        data: 'https://vetsinindia.blogspot.com/'
                    );
                    await intent.launch();
                  },
                ),

                buildMenuItems(
                  text: 'Animal Welfare Organisation',
                  icon:  LineIcons.medkit,
                  onClicked: () async {
                    AndroidIntent intent = AndroidIntent(
                        action: "action_view",
                        data: 'http://animalwelfareorganisations.blogspot.com/'
                    );
                    await intent.launch();
                  },
                ),


                buildMenuItems(
                  text: 'About',
                  icon: LineIcons.infoCircle,
                  onClicked: () => selectedItem(context,2),
                ),

                buildMenuItems(
                  text: 'Feedback',
                  icon: LineIcons.envelopeAlt,
                  onClicked: () {
                    _sendEmail();
                  }
                ),


                buildMenuItems(
                  text: 'Logout',
                  icon: LineIcons.alternateSignOut,
                  onClicked: () async {
                    await _auth.signOut();
                  }
                ),
                SizedBox(height: 30,),
                Divider(
                  color: Colors.teal[500],
                  height: 10.0,
                  thickness: 1,
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Icon(LineIcons.copyrightAlt,
                      color: Colors.white,
                      size: 18,),
                    SizedBox(width: 10,),
                    RichText(
                      text: TextSpan(
                        text: '2021 All Rights Reserved!',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems({String text, IconData icon, VoidCallback onClicked}) {
    final _color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: _color,),
      title: Text(text, style: TextStyle(color: _color),),
      onTap: onClicked,
    );

  }

  Widget buildHeader({name}) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/dog1.jpg'),
              radius: 35.0,
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: 'Welcome!',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 10,),
          RichText(
              text: TextSpan(
                text: name,
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
          ),
          SizedBox(height: 40,),
          Divider(
            color: Colors.teal[500],
            height: 10.0,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Authenticate(),
        )
        );
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UploadForm(),
        )
        );
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutUs(),
        )
        );
        break;

    }
  }
}
