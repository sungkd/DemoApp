import 'package:flutter/material.dart';
import 'package:fluuter_provider/home/update_form.dart';
import 'package:fluuter_provider/screens/upload_form.dart';
import 'package:fluuter_provider/services/auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/home/datalist.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/screens/user_upload.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showUpdatePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: UpdateForm(),
            );
          }
      );
    }

    return StreamProvider<List<DispData>>.value(
      value: DatabaseService().petUpload,
      child: Scaffold(
        backgroundColor: Color(0xff416d6d),
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Pet Adopt'),
          backgroundColor: Color(0xff416d6d),
          //backgroundColor: Colors.grey[800],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person,
                  color: Colors.white),
              label: Text('Logout',
                  style: TextStyle(color: Colors.white)
              ),
            ),

            // Update Status
            // TextButton.icon(
            //   icon: Icon(Icons.settings,
            //       color: Colors.white),
            //   label: Text('Update Status',
            //       style: TextStyle(color: Colors.white)
            //   ),
            //   onPressed: () => _showUpdatePanel(),
            // )
          ],
        ),
        body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/dog1.jpg'),
                    fit: BoxFit.cover
                ),
              ),
              child: DataList(),),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red[800],
          autofocus: true,
          hoverColor: Colors.teal[800],
          child: Icon(LineIcons.plus),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => UploadForm(),
            )
            );
          },
        ),
      ),
    );
  }
}
