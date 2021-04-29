import 'package:flutter/material.dart';
import 'package:fluuter_provider/screens/upload_form.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluuter_provider/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_provider/home/datalist.dart';
import 'package:fluuter_provider/modals/fetchdata.dart';
import 'package:fluuter_provider/constants/navigate.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<DispData>>.value(
      initialData: [],
      value: DatabaseService().petUpload,
      child: Scaffold(
        backgroundColor: Color(0xff416d6d),
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: "Pet Adopt",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 15.0,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffFF045C5C),
          //backgroundColor: Colors.grey[800],
          elevation: 1.2,
        ),

        body: SafeArea(
          child: DataList(),
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

  Widget buildImages() => SliverToBoxAdapter(
    child: DataList(),
  );
}
